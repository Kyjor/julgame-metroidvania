module Metroidvania 
    using JulGame
    using JulGame.Math
    using JulGame.SceneBuilderModule

    function run()
        JulGame.MAIN = JulGame.Main(Float64(1.0))
        JulGame.PIXELS_PER_UNIT = 16
        scene = SceneBuilderModule.Scene("scene.json")
        SceneBuilderModule.load_and_prepare_scene(;this=scene)
    end

    julia_main() = run()
end
# Uncommented to allow for direct execution of this file. If you want to build this project with PackageCompiler, comment the line below
Metroidvania.run()