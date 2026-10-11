/*
 * Вращающийся куб с "дышащим" цветом.
 *
 * Цветовое дыхание - те же три синуса со сдвигом фаз на 120 градусов,
 * которыми в старом тесте закрашивалось окно целиком.
 *
 * Освещение простое: направленный свет (ламберт) + ambient. Направление
 * света приходит в объектных координатах - тогда HLSL не нужен второй
 * матричный push (весь кадр укладывается в 128 байт констант).
 */

struct CubeConstants
{
    // Строки матрицы ModelViewProjection: по float4 на строку.
    // Так HLSL-компилятору не остаётся места для сюрпризов с упаковкой
    // float4x4 (row_major / column_major).
    float4 mvpRows[4];

    // xyz - направление света в объектных координатах, w - время (секунды)
    float4 lightAndTime;

    // rgb - базовый цвет
    float4 baseColor;
};

[[vk::push_constant]] ConstantBuffer<CubeConstants> push;

struct VertexInput
{
    float3 position : POSITION;
    float3 normal : NORMAL;
};

struct VertexOutput
{
    float4 position : SV_Position;
    float3 normal : TEXCOORD0;
};

VertexOutput mainVS(VertexInput input)
{
    VertexOutput output;

    // clip = ModelViewProjection * позиция (по строке матрицы на компонент).
    float4 position = float4(input.position, 1.0);

    output.position = float4(
        dot(push.mvpRows[0], position),
        dot(push.mvpRows[1], position),
        dot(push.mvpRows[2], position),
        dot(push.mvpRows[3], position));

    output.normal = input.normal;

    return output;
}

float4 mainPS(VertexOutput input) : SV_Target
{
    float3 normal = normalize(input.normal);
    float3 lightDirection = normalize(push.lightAndTime.xyz);

    float time = push.lightAndTime.w;

    // Дыхание цвета: фазы сдвинуты на 2PI/3.
    float3 tint = 0.5 + 0.5 * sin(time + float3(0.0, 2.0944, 4.1888));

    float lambert = saturate(dot(normal, lightDirection));

    float lighting = 0.25 + 0.85 * lambert;

    float3 color = push.baseColor.rgb * tint * lighting;

    return float4(color, 1.0);
}
