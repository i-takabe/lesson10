Shader "Unlit/NoiseShader"
{
    SubShader
    {
		Cull Off
		Zwrite Off
		ZTest Always

        Pass
        {
            CGPROGRAM

            #include "UnityCustomRenderTexture.cginc"

			#pragma vertex CustomRenderTextureVertexShader
			#pragma fragment frag
			#pragma target 3.0

			fixed2 random2(float2 st) 
			{
				st = float2(dot(st, fixed2(337.1, 811.7)),
						    dot(st, fixed2(149.5, 693.3)));

				return -1.0 + 2.0 * frac(sin(st) * 43758.87647886);
			}

		float Noise(float2 st) 
		{
			float2 p = floor(st);
			float2 f = frac(st);
			float2 u = f * f * (3.0 - 2.0 * f);

			float v00 = random2(p + fixed2(0, 0));
			float v10 = random2(p + fixed2(1, 0));
			float v01 = random2(p + fixed2(0, 1));
			float v11 = random2(p + fixed2(1, 1));

			return lerp(lerp(dot(random2(p + float2(0.0, 0.0)), f - float2(0.0, 0.0)),
							 dot(random2(p + float2(1.0, 0.0)), f - float2(1.0, 0.0)), u.x),
						lerp(dot(random2(p + float2(0.0, 1.0)), f - float2(0.0, 1.0)),
							 dot(random2(p + float2(1.0, 1.0)), f - float2(1.0, 1.0)), u.x), u.y);
		}

		float Fbm(float2 texcoord)
		{
			float a1 = 1.0;
			float a2 = 0.5;
			float a3 = 0.25;

			float2 tc = texcoord * float2(.05, .05);
			float time = _Time.y * 0.5;

			float noise = Noise((tc + time) * 1.0) * a1
						+ Noise((tc + time) * 2.0) * a2
						+ Noise((tc + time)* 4.0) * a3;
			noise = noise / (a1 + a2 + a3); //normalize

			return noise;
		}

            float2 frag (v2f_customrendertexture i) : SV_Target
            {
				return float2(
					Fbm(i.localTexcoord),
					Fbm(i.localTexcoord + float2(1000.0, 1000.0)));
            }
            ENDCG
        }
    }
}
