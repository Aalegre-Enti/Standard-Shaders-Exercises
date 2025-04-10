Shader "Unlit/E1.4"
{
    Properties
    {
        _Speed ("_Speed", float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            float _Speed;
            fixed4 frag (v2f i) : SV_Target
            {
                fixed col = abs(sin(_Time.g * _Speed));
                float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
                float3 P = abs(frac(col + K.xyz) * 6.0 - K.www);
                return fixed4(saturate(P - K.xxx),1);
            }
            ENDCG
        }
    }
}
