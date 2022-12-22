package test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.guide.sample.dto.SampleDTO;

 /**
 * TestDTOConvert에 대한 설명 작성
 * @ClassName TestDTOConvert.java
 * @Description TestDTOConvert Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 26.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 2. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class TestDTOConvert {

	public static void main(String[] args) {
		try {
			testDtoToMap();
			testDtoToMapList();
			testMapToDto ();
			testMapToDtoList ();
			
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	private static void testDtoToMap () throws Exception {
		SampleDTO sampleDTO = new SampleDTO();
		sampleDTO.setId("1234");
		sampleDTO.setDescription("가나다라마");
		sampleDTO.setName("abcd");
		
		Map <String, Object> map = DTOUtil.convertVoToMap(sampleDTO);
		System.out.println (map.toString());
	}

	@SuppressWarnings("unchecked")
	private static void testDtoToMapList () throws Exception {
		SampleDTO sampleDTO = new SampleDTO();
		sampleDTO.setId("1234");
		sampleDTO.setDescription("가나다라마");
		sampleDTO.setName("abcd");

		SampleDTO sample2DTO = new SampleDTO();
		sample2DTO.setId("2345");
		sample2DTO.setDescription("2가나다라마");
		sample2DTO.setName("2abcd");

		List listDTO = (List) new ArrayList<SampleDTO>();
		listDTO.add(sampleDTO);
		listDTO.add(sample2DTO);
		
		List listMap = (List)DTOUtil.convertVoToMapList((List)listDTO);
		
		System.out.println (listMap.toString());
	}

	private static void testMapToDto () throws Exception {
		Map<String, Object> map = new HashMap ();
		map.put("id", "1234");
		map.put("description", "가나다라마");
		map.put("name", "abcd");
		
		//방법1) VO 객체를 넘기는 경우
		//SampleVO sampleDTO = new SampleVO();
		//sampleDTO = (SampleVO)VOUtil.convertMapToVO(map, sampleDTO);
		
		//방벙2) VO Class를 넘기는 경우
		SampleDTO sampleDTO;
		sampleDTO = (SampleDTO)DTOUtil.convertMapToVo(map, SampleDTO.class);

		System.out.println (sampleDTO.toString());
	}

	private static void testMapToDtoList () throws Exception {
		List<Map<String, Object>> listMap = new ArrayList();
		Map<String, Object> map = new HashMap ();
		map.put("id", "1234");
		map.put("description", "가나다라마");
		map.put("name", "abcd");
		
		Map<String, Object> map2 = new HashMap ();
		map2.put("id", "21234");
		map2.put("description", "2가나다라마");
		map2.put("name", "2abcd");
		
		listMap.add (map);
		listMap.add (map2);
		
		List<SampleDTO> listDTO;
		listDTO = (List)DTOUtil.convertMapToVoList(listMap, SampleDTO.class);

		System.out.println (listDTO.toString());
	}
}
