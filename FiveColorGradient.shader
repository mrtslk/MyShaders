Shader "Murat/GradientEndGame" 
{
    Properties
    {
        _Color1("Color1", Color) = (0,0,1,1)
        _Color2("Color2", Color) = (1,0,0,1)
        _Color3("Color3", Color) = (1,0,0,1)
        _Color4("Color4", Color) = (1,0,0,1)
        _Color5("Color5", Color) = (1,0,0,1)
        [Toggle] _UseAlpha("Use Alpha", Float) = 0
        _Start("Start", Float) = 0
        _End("End", Float) = 0
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0


    }
        SubShader
        {
            Tags 
            {
            "RenderType" = "Transparent"
            }
            LOD 200
            ZWrite On

            CGPROGRAM
            #pragma surface surf Standard  vertex:vert Lambert alpha
            #pragma target 3.0

            half _Glossiness;
            half _Metallic;
            fixed4 _Color1;
            fixed4 _Color2;
            fixed4 _Color3;
            fixed4 _Color4;
            fixed4 _Color5;
            fixed  _Start;
            fixed  _End;
            float _UseAlpha;

            struct Input 
            {
                float2 uv_MainTex;
                float3 localPos;

            };

            void vert(inout appdata_full v, out Input o) 
            {
                UNITY_INITIALIZE_OUTPUT(Input,o);
                o.localPos = v.vertex.xyz;
            }

            void surf(Input IN, inout SurfaceOutputStandard o) 
            {
                float Step = (_End - _Start) / 4;
                float _MiddleBot = _Start + Step;
                float _Middle = _Start + 2* Step;
                float _MiddleTop = _Start + 3 * Step;
                half4 c;
                c.rgba = lerp(_Color1, _Color2, IN.localPos.y / _MiddleBot) * step(IN.localPos.y, _MiddleBot);
                c += lerp(_Color2, _Color3, (IN.localPos.y - _MiddleBot) / (_Middle - _MiddleBot)) * step(_MiddleBot, IN.localPos.y) * step(IN.localPos.y, _Middle);
                c += lerp(_Color3, _Color4, (IN.localPos.y - _Middle) / (_MiddleTop - _Middle)) * step(_Middle, IN.localPos.y) * step(IN.localPos.y, _MiddleTop);
                c += lerp(_Color4, _Color5, (IN.localPos.y - _MiddleTop) / (_End - _MiddleTop)) * step(_MiddleTop, IN.localPos.y);
                if(_UseAlpha==0)
                    c.a = 1;

                o.Albedo = c.rgb;
                o.Alpha =c.a;
                o.Metallic = _Metallic;
                o.Smoothness = _Glossiness;

            }
            ENDCG
        }
            Fallback "Diffuse"
}