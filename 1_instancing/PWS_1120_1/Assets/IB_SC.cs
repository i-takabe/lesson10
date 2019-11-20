using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Assertions;

public class IB_SC : MonoBehaviour
{
	public Color color = Color.green;

    // Start is called before the first frame update
    void Start()
    {
		var renderer = GetComponent<Renderer>();
		Assert.IsNotNull(renderer);

		MaterialPropertyBlock block = new MaterialPropertyBlock();
		color.a = 0.0f;
		block.SetColor("_Color", color);

		renderer.SetPropertyBlock(block);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
