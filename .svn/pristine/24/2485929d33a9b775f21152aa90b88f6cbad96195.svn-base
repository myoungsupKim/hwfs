package com.hwfs.ei.cmn;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.json.JSONObject;

 /**
 * RequestUtils에 대한 설명 작성
 * @ClassName RequestUtils.java
 * @Description RequestUtils Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 11. 24.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 김재섭
 * @since 2015. 11. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class RequestUtils {

	public static Map<String, Object> JSONObject2Map(JSONObject parameter) throws Exception {
		Map<String, Object> ret = new HashMap<String, Object>();
		Iterator<?> keys = parameter.keys();
		
		while(keys.hasNext()) {
			String key = keys.next().toString();
			ret.put(key, parameter.get(key));
		}
		
		return ret;
	}
}
