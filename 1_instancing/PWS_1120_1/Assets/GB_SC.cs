using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GB_SC : MonoBehaviour
{
	public IB_SC prefab;
	public int INSTANCE_NUM = 1000;
	private int last_instance_num = 1000;

	void Generate()
	{
		for(int i = 0; i < INSTANCE_NUM; i++)
		{
			var inst = Instantiate(prefab);

			inst.transform.parent = gameObject.transform;

			float y = Random.Range(0.3f, 1.5f);
			inst.transform.localScale = new Vector3(0.1f, y, 0.05f);

			inst.transform.position = new Vector3(Random.Range(-5.0f, 5.0f), y, Random.Range(-5.0f, 5.0f));
		}
	}

    // Start is called before the first frame update
    void Start()
    {
		Generate();
    }

    // Update is called once per frame
    void Update()
    {
        if(last_instance_num != INSTANCE_NUM)
		{
			last_instance_num = INSTANCE_NUM;

			for (int i = 0; i < gameObject.transform.childCount; i++)
			{
				Destroy(gameObject.transform.GetChild(i).gameObject);
			}

			Generate();
		}
    }
}
