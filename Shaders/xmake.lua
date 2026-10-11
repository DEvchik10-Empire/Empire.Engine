set_project("Empire.Shaders")

-- HLSL -> SPIR-V.
--
-- Источники лежат в Hlsl/, готовые .spv собираются в SpirV/ (артефакты
-- сборки, в репозиторий коммитить не обязательно). Загрузкой .spv в
-- рантайме занимается Rendering (см. Empire.Pipeline/Vulkan/VkShader).
--
-- Сборка:
--   xmake build Empire.Shaders
--
-- Компилятор: glslangValidator с HLSL-фронтендом (-D), тот же, что
-- поставляется с Vulkan SDK.

local HlslRoot = path.absolute("Hlsl")
local SpirvRoot = path.absolute("SpirV")

local Shaders =
{
    "Sky.hlsl",
    "Cube.hlsl"
}

-- name    - имя выходного файла (<Shader>.<name>.spv)
-- stage   - точка входа в шейдере (-S)
-- entry   - имя функции входа (-e)
local Stages =
{
    {name = "vert", stage = "vert", entry = "mainVS"},
    {name = "frag", stage = "frag", entry = "mainPS"}
}

target("Empire.Shaders")
    set_kind("phony")

    on_build(function (target)
        os.mkdir(SpirvRoot)

        for _, shader in ipairs(Shaders) do
            local source = path.join(HlslRoot, shader)
            local name = shader:gsub("%.hlsl$", "")

            for _, stage in ipairs(Stages) do
                local output = path.join(
                    SpirvRoot,
                    name .. "." .. stage.name .. ".spv"
                )

                print("[Shaders] " .. shader .. " (" .. stage.name .. ")")

                os.execv("glslangValidator", {
                    "-D",
                    "-V",
                    "--target-env", "vulkan1.1",
                    "-S", stage.stage,
                    "-e", stage.entry,
                    source,
                    "-o", output
                })
            end
        end
    end)
