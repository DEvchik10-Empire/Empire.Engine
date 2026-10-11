/*
 * Стилизованное ночное небо (по мотивам скрина sky_night-1.jpg):
 * индигово-синий градиент, луна с ореолом, редкие звёзды и большие
 * мягкие облака с подсветкой с лунной стороны.
 *
 * Облака НЕ объёмные: два 2D-слоя через проекцию dir.xz / dir.y.
 * Проекция сама даёт нужную перспективу - крупные куски в зените
 * и вытянутые полосы у горизонта. Дешевле ray march'а и форма
 * читается как на референсе.
 *
 * Подсветка: у кромки сравнивается плотность в пикселе и в точке,
 * сдвинутой к луне - кромка, обращённая к луне, светлее.
 *
 * Рисуется полноэкранным треугольником (по SV_VertexID, без вершинного
 * буфера) ДО сцены, без записи в depth.
 *
 * Константы приходят push-блоком (см. SkyConstants в Tests/Rendering).
 */


#define PI 3.14159265359

// ============================================================
// Push constants: совместимы с исходным SkyConstants.
// Размер: 128 байт.
// ============================================================

struct SkyConstants
{
    float4 cameraRight;       // xyz: right, w: tan(fov / 2)
    float4 cameraUp;           // xyz: up, w: aspect ratio
    float4 cameraForward;      // xyz: forward, w: time
    float4 sunDirection;       // xyz: sun direction, w: stars intensity
    float4 topColor;           // rgb: zenith, w: legacy cloud threshold
    float4 bottomColor;        // rgb: horizon
    float4 sunScatterColor;    // rgb: scatter tint, w: intensity
    float4 cloudsColor;        // rgb: cloud lighting
};

[[vk::push_constant]]
ConstantBuffer<SkyConstants> push;


// ============================================================
// Settings: обычный uniform buffer.
// Размер и layout должны совпадать с данными CPU.
// ============================================================

struct SkySettings
{
    float cloudsDensity;
    float cloudsScale;
    float cloudsSmoothness;
    float cloudsShadowIntensity;

    float cloudsSamples;
    float shadowSamples;
    float highCloudsDensity;
    float highCloudsScale;

    float astroScale;
    float astroIntensity;
    float shootingStarsIntensity;
    float starsIntensity;

    float4 astroTint;
    float4 shootingStarTint;
};

[[vk::binding(0, 0)]]
ConstantBuffer<SkySettings> settings;


// ============================================================
// Textures and samplers.
//
// Descriptor set 0:
//  1 - cloud shape texture
//  2 - shape sampler
//  3 - cloud noise texture
//  4 - noise sampler
//  5 - cloud curves texture
//  6 - curves sampler
//  7 - high clouds texture
//  8 - high clouds sampler
//  9 - astronomy texture
// 10 - astronomy sampler
// 11 - shooting star texture
// 12 - shooting star sampler
// ============================================================

[[vk::binding(1, 0)]]
Texture2D<float4> cloudShapeTexture;

[[vk::binding(2, 0)]]
SamplerState cloudShapeSampler;

[[vk::binding(3, 0)]]
Texture2D<float4> cloudNoiseTexture;

[[vk::binding(4, 0)]]
SamplerState cloudNoiseSampler;

[[vk::binding(5, 0)]]
Texture2D<float4> cloudCurvesTexture;

[[vk::binding(6, 0)]]
SamplerState cloudCurvesSampler;

[[vk::binding(7, 0)]]
Texture2D<float4> highCloudsTexture;

[[vk::binding(8, 0)]]
SamplerState highCloudsSampler;

[[vk::binding(9, 0)]]
Texture2D<float4> astroTexture;

[[vk::binding(10, 0)]]
SamplerState astroSampler;

[[vk::binding(11, 0)]]
Texture2D<float4> shootingStarTexture;

[[vk::binding(12, 0)]]
SamplerState shootingStarSampler;


// ============================================================
// Vertex input/output
// ============================================================

struct VertexOutput
{
    float4 position : SV_Position;
    float3 direction : TEXCOORD0;
};


VertexOutput mainVS(uint vertexId : SV_VertexID)
{
    // Fullscreen triangle.
    float2 uv = float2(
        (vertexId << 1) & 2,
        vertexId & 2
    );

    float2 ndc = uv * 2.0 - 1.0;

    float3 direction =
        push.cameraForward.xyz
        + ndc.x
        * push.cameraRight.w
        * push.cameraUp.w
        * push.cameraRight.xyz
        - ndc.y
        * push.cameraRight.w
        * push.cameraUp.xyz;

    VertexOutput output;
    output.position = float4(ndc, 0.0, 1.0);
    output.direction = direction;

    return output;
}


// ============================================================
// Random and Voronoi
// ============================================================

float rand(float n)
{
    return frac(sin(n) * 43758.5453123);
}


float3 hash3(float3 x)
{
    x = float3(
        dot(x, float3(127.1, 311.7, 74.7)),
        dot(x, float3(269.5, 183.3, 246.1)),
        dot(x, float3(113.5, 271.9, 124.6))
    );

    return frac(sin(x) * 43758.5453123);
}


float3 voronoi(float3 x)
{
    float3 p = floor(x);
    float3 f = frac(x);

    float id = 0.0;
    float2 result = float2(100.0, 100.0);

    [unroll]
    for (int k = -1; k <= 1; ++k)
    {
        [unroll]
        for (int j = -1; j <= 1; ++j)
        {
            [unroll]
            for (int i = -1; i <= 1; ++i)
            {
                float3 b = float3(i, j, k);
                float3 r = b - f + hash3(p + b);
                float d = dot(r, r);

                if (d < result.x)
                {
                    id = dot(
                        p + b,
                        float3(1.0, 57.0, 113.0)
                    );

                    result = float2(d, result.x);
                }
                else if (d < result.y)
                {
                    result.y = d;
                }
            }
        }
    }

    return float3(sqrt(result), abs(id));
}


// ============================================================
// Direction transforms
// ============================================================

float3 DirectionToLocal(float3 direction, float3 forward)
{
    forward = normalize(forward);

    float3 referenceUp = float3(0.0, 1.0, 0.0);

    // Avoid a degenerate basis near the vertical axis.
    if (abs(dot(referenceUp, forward)) > 0.999)
        referenceUp = float3(0.0, 0.0, 1.0);

    float3 right = normalize(cross(referenceUp, forward));
    float3 up = normalize(cross(forward, right));

    return float3(
        dot(direction, right),
        dot(direction, up),
        dot(direction, forward)
    );
}


float3 RandomDirection(float seed)
{
    float phi = rand(seed) * 2.0 * PI;
    float y = rand(seed + 100.0) * 2.0 - 1.0;
    float radius = sqrt(max(0.0, 1.0 - y * y));

    return float3(
        radius * cos(phi),
        y,
        radius * sin(phi)
    );
}


// ============================================================
// Volumetric-style cloud density
// ============================================================

float CloudDensity(float3 p, float progress, float time)
{
    float noiseTime = time * -0.005;
    float shapeTime = time * 0.001;

    float noise = cloudNoiseTexture.SampleLevel(
        cloudNoiseSampler,
        p.xy * 4.0 + noiseTime,
        0.0
    ).r;

    noise = noise * 0.1 + 0.9;

    float shape = cloudShapeTexture.SampleLevel(
        cloudShapeSampler,
        (p.xy + shapeTime) * settings.cloudsScale,
        0.0
    ).r;

    float heightCurve = cloudCurvesTexture.SampleLevel(
        cloudCurvesSampler,
        float2(saturate(progress), 0.5),
        0.0
    ).r;

    float threshold = 1.0 - saturate(settings.cloudsDensity);

    float density = shape * noise * heightCurve;

    return smoothstep(
        threshold - settings.cloudsSmoothness,
        threshold + settings.cloudsSmoothness,
        density
    );
}


// ============================================================
// Cloud ray marching
//
// x: accumulated density
// y: accumulated illumination
// ============================================================

float2 CloudRayMarch(float3 direction, float3 sunDirection, float time)
{
    float density = 0.0;
    float light = 0.0;

    float height = 0.03;

    int samples = clamp((int)settings.cloudsSamples, 8, 32);
    int shadowSamples = clamp((int)settings.shadowSamples, 1, 4);

    [loop]
    for (int i = 0; i < samples; ++i)
    {
        float progress = (float(i) + 0.5) / float(samples);

        // Sample the cloud layer along the viewing ray.
        float3 samplePoint = direction * height * (progress + 3.0);

        float pointDensity = CloudDensity(
            samplePoint,
            progress,
            time
        );

        density += pointDensity;

        float pointLight = 0.0;

        [loop]
        for (int j = 0; j < shadowSamples; ++j)
        {
            float shadowProgress =
                (float(j) + 0.5) / float(shadowSamples);

            float3 shadowOffset =
                sunDirection * height * shadowProgress;

            pointLight += CloudDensity(
                samplePoint + shadowOffset,
                progress,
                time
            );
        }

        light += pointLight / float(shadowSamples);
    }

    float normalizedDensity = density / float(samples);
    float normalizedLight = light / float(samples);

    return float2(
        saturate(normalizedDensity),
        saturate(normalizedLight)
    );
}


// ============================================================
// Shooting stars
// ============================================================

float GetShootingStar(float3 eyeDirection, float time)
{
    float result = 0.0;

    [unroll]
    for (int i = 0; i < 4; ++i)
    {
        float baseRandom = rand(float(i));

        float duration = 0.5 + baseRandom;
        float localTime = time + baseRandom * 2.0;

        float seed = floor(localTime / duration) * duration
                   + baseRandom;

        float progress = frac(localTime / duration);
        float randomValue = rand(seed + 100.0);

        float3 forward = RandomDirection(seed);
        float3 localDirection = DirectionToLocal(
            eyeDirection,
            forward
        );

        float angle = randomValue * 0.8;

        float2 rotated = float2(
            cos(angle) * localDirection.x
                - sin(angle) * localDirection.y,

            sin(angle) * localDirection.x
                + cos(angle) * localDirection.y
        );

        float scale = 8.0 + baseRandom * 10.0;

        float2 uv = rotated * scale
                  + float2(0.5, 0.5 + progress * 0.4 * scale);

        float2 maskUV = saturate(uv * (1.0 - uv));

        float mask =
            step(0.0, localDirection.z)
            * step(0.0, uv.x)
            * step(uv.x, 1.0)
            * step(0.0, uv.y)
            * step(uv.y, 1.0);

        float shape = maskUV.x * maskUV.y;

        float star = shootingStarTexture.SampleLevel(
            shootingStarSampler,
            uv,
            0.0
        ).r;

        star *= sin(progress * PI);
        star *= mask * randomValue;
        star *= saturate(shape * 64.0);

        result = saturate(result + star);
    }

    return result;
}


// ============================================================
// Pixel shader
// ============================================================

float4 mainPS(VertexOutput input) : SV_Target
{
    float3 direction = normalize(input.direction);
    float3 sunDirection = normalize(push.sunDirection.xyz);

    float time = push.cameraForward.w;

    // --------------------------------------------------------
    // Sky gradient and horizon scatter
    // --------------------------------------------------------

    float gradient = saturate(direction.y);

    float3 skyGradient = lerp(
        push.bottomColor.rgb,
        push.topColor.rgb,
        gradient
    );

    float horizonMask = 1.0 - saturate(abs(direction.y));

    float3 color = skyGradient
        + push.sunScatterColor.rgb
        * horizonMask
        * push.sunScatterColor.w;

    // --------------------------------------------------------
    // Stars
    // --------------------------------------------------------

    float starIntensity = max(
        settings.starsIntensity,
        push.sunDirection.w
    );

    if (starIntensity > 0.0)
    {
        float3 starData = voronoi(direction * 25.0);

        float starRadius =
            0.025
            + (1.0 + sin(time + starData.z)) * 0.025;

        float star = 1.0 - smoothstep(
            0.0,
            starRadius,
            starData.x
        );

        color += star
            * starIntensity
            * float3(0.9, 0.95, 1.0);
    }

    // --------------------------------------------------------
    // Shooting stars
    // --------------------------------------------------------

    if (settings.shootingStarsIntensity > 0.0)
    {
        float shootingStar = GetShootingStar(direction, time);

        color += shootingStar
            * settings.shootingStarsIntensity
            * settings.shootingStarTint.rgb;
    }

    // --------------------------------------------------------
    // Astronomy texture
    // --------------------------------------------------------

    float3 astroDirection = DirectionToLocal(
        direction,
        sunDirection
    );

    float safeZ = max(abs(astroDirection.z), 0.0001);

    float2 astroUV =
        -astroDirection.xy / safeZ * settings.astroScale
        + 0.5;

    bool astroVisible =
        astroDirection.z > 0.0
        && all(astroUV >= 0.0)
        && all(astroUV <= 1.0);

    if (astroVisible)
    {
        float4 astro = astroTexture.SampleLevel(
            astroSampler,
            astroUV,
            0.0
        );

        color = lerp(
            color,
            astro.rgb
                * settings.astroTint.rgb
                * settings.astroIntensity,
            astro.a
        );
    }

    // --------------------------------------------------------
    // High clouds
    // --------------------------------------------------------

    if (settings.highCloudsDensity > 0.0)
    {
        float safeY = max(direction.y, 0.025);

        float2 highUV =
            direction.xz / safeY
            * settings.highCloudsScale
            + time * 0.001;

        float highMask = highCloudsTexture.SampleLevel(
            highCloudsSampler,
            highUV,
            0.0
        ).r;

        float highAlpha = smoothstep(0.0, 1.0, highMask)
            * horizonMask
            * saturate(settings.highCloudsDensity);

        color = lerp(
            color,
            push.cloudsColor.rgb,
            highAlpha
        );
    }

    // --------------------------------------------------------
    // Main clouds
    // --------------------------------------------------------

    if (settings.cloudsDensity > 0.0 && direction.y > 0.0)
    {
        float safeY = max(direction.y, 0.025);

        float3 cloudDirection = float3(
            direction.x / safeY,
            direction.z / safeY,
            1.0
        );

        float2 clouds = CloudRayMarch(
            cloudDirection,
            sunDirection,
            time
        );

        float cloudOpacity =
            1.0 - exp(-clouds.x * horizonMask * 10.0);

        float cloudLight =
            exp(-clouds.y * settings.cloudsShadowIntensity);

        float3 cloudColor = lerp(
            push.topColor.rgb,
            push.cloudsColor.rgb,
            cloudLight
        );

        color = lerp(
            color,
            cloudColor,
            saturate(cloudOpacity)
        );
    }

    // --------------------------------------------------------
    // Ground below horizon
    // --------------------------------------------------------

    float groundMask = 1.0 - smoothstep(
        -0.015,
        0.015,
        direction.y
    );

    float3 groundColor = float3(0.30, 0.31, 0.62);

    color = lerp(color, groundColor, groundMask);

    return float4(saturate(color), 1.0);
}

