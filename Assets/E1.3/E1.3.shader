Shader "Unlit/E1.3"
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
                // sample the texture
                fixed col = abs(sin(_Time.g * _Speed));
                return col;
            }
            ENDCG
        }
    }
}
