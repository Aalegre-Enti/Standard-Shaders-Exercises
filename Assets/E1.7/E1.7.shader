Shader "Custom/E1.7"
{
    Properties
    {
        _Color ("_Color", Color) = (1,1,1,1)
        _MainTex ("_MainTex", 2D) = "white" {}
        _NormalMap ("_NormalMap", 2D) = "bump" {}
        _NormalIntensity ("_NormalIntensity", float) = 1
        _MetallicSmoothness ("_MetallicSmoothness", 2D) = "white" {}
        _Metallic ("_Metallic", Range(0,1)) = 0
        _Smoothness ("_Smoothness", Range(0,1)) = 0.5
        _AmbientOcclusionMap ("_AmbientOcclusionMap", 2D) = "white" {}
        [HDR] _Emission ("_Emission", Color) = (0,0,0,0)
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

        half _NormalIntensity;
        half _Smoothness;
        half _Metallic;
        fixed4 _Color;
        float4 _Emission;
        sampler2D _NormalMap;
        sampler2D _MetallicSmoothness;
        sampler2D _AmbientOcclusionMap;
        sampler2D _EmissionMap;

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
            o.Normal = UnpackScaleNormal (tex2D (_NormalMap, IN.uv_MainTex), _NormalIntensity);
            // Metallic and smoothness come from slider variables
            fixed4 ms = tex2D (_MetallicSmoothness, IN.uv_MainTex);
            o.Metallic = ms.r * _Metallic;
            o.Smoothness = ms.a *_Smoothness;
            o.Occlusion = tex2D (_AmbientOcclusionMap, IN.uv_MainTex);
            o.Emission = tex2D (_EmissionMap, IN.uv_MainTex) * _Emission;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
