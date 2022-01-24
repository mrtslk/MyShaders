Shader "Murat/UV Shift"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
        _ScrollXSpeed("X scroll speed", Range(-10, 10)) = 0
        _ScrollYSpeed("Y scroll speed", Range(-10, 10)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        fixed _ScrollXSpeed;
        fixed _ScrollXSpeed;
        fixed _ScrollYSpeed;
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float _Offset;
        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed offsetX = _ScrollXSpeed*2 * _Time;
            fixed offsetY = _ScrollYSpeed*2 * _Time;
            fixed2 offsetUV = fixed2(offsetX, offsetY);

            fixed2 mainUV = IN.uv_MainTex + offsetUV;

            float4 c = tex2D(_MainTex, mainUV);
            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;

        }
        ENDCG
    }
    FallBack "Diffuse"
}
