Shader "Murat/AlphaChannelTexture"
{
    Properties
    {
        _Color ("Color",Color)=(1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _AlphaTex ("Alpha (RGBA)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Opaque" }
        ZWrite Off
        CGPROGRAM
        #pragma surface surf Lambert alpha
        sampler2D _MainTex;
        sampler2D _AlphaTex;
        float4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            half4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            half4 d = tex2D(_AlphaTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = d.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
