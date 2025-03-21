Shader "Custom/E1.7"
{
    Properties
    {
        _Color ("_Color", Color) = (1,1,1,1)
        _MainTex ("_MainTex", 2D) = "white" {}
        _NormalMap ("_NormalMap", 2D) = "bump" {}
        _NormalIntensity ("_NormalIntensity", Range(0,1)) = 1
        _MetallicSmoothness ("_MetallicSmoothness", 2D) = "white" {}
        _Metallic ("_Metallic", Range(0,1)) = 0
        _Smoothness ("_Smoothness", Range(0,1)) = 0.5
        _AmbientOcclusionMap ("_AmbientOcclusionMap", 2D) = "white" {}
        [HDR] _Emission ("_Emission", Color) = (1,1,1,1)
        _EmissionMap ("_EmissionMap", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
