package com.hwfs.sc.cmn.sap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * EAI의 응답결과.
 *
 * @ClassName EAIResponse.java
 * @Description EAIResponse Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 10.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 4. 10.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class EAIResponse {
	private JSONObject response = null;
	private boolean isSuccess = false;
	private int errorCode = 0;
	private String errorMsg = "";
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * EAI 응답객체 생성자
	 *
	 * <pre>
	 * Constructor 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param value
	 */
	public EAIResponse(StringBuffer value) {
		JSONObject val = null;
		try {
			val = new JSONObject(value.toString());

			if (val.get("message") instanceof JSONObject) {
				response = val.getJSONObject("message");
				this.isSuccess = true;
				this.errorCode = 0;
				this.errorMsg = "성공";
			} else {
				response = val;
				this.isSuccess = false;
				this.errorCode = -1;
				this.errorMsg = "결과가 없습니다.";
			}
		} catch (JSONException e) {
			this.isSuccess = false;
			this.errorCode = -999;
			this.errorMsg = e.toString() + " => EAI 반환문자 : " + value;
		}
	}

	/**
	 * EAI와 통신을 성공하고 정상적인 결과를 수신했는지를 체크한다.
	 *
	 * <pre>
	 * true인 경우에는 통신과 정상적인 결과를 수신함.
	 * false인 경우에는 getErrorCode()와 getErrorMsg()를 이용하여 확인한다.
	 * </pre>
	 *
	 * @return
	 */
	public boolean isSuccess() {
		return this.isSuccess;
	}

	/**
	 * 사용금지-PMD에서 걸려서 임시로 만듬.
	 *
	 * @param val
	 */
	public void isSuccess(boolean val) {
		this.isSuccess = val;
	}

	/**
	 * EAI와 통신 실패 혹은 전송된 결과가 없는 경우에 대한 Error Code를 반환한다.
	 *
	 * <pre>
	 * 0을 반환할 경우에는 성공
	 * -1을 반환할 경우에는 결과가 없는 경우
	 * -999를 반환할 경우에는 그 외의 Exception이 발생한 경우
	 * </pre>
	 *
	 * @return
	 */
	public int getErrorCode() {
		return this.errorCode;
	}

	/**
	 * 사용금지-PMD에서 걸려서 임시로 만듬.
	 *
	 * @param val
	 */
	public void setErrorCode(int val) {
		this.errorCode = val;
	}

	/**
	 * Error Code에 대한 Message를 반환한다.
	 *
	 * @return
	 */
	public String getErrorMsg() {
		return this.errorMsg;
	}

	/**
	 * 사용금지-PMD에서 걸려서 임시로 만듬.
	 *
	 * @param val
	 */
	public void setErrorMsg(String val) {
		this.errorMsg = val;
	}

	/**
	 * 조회 결과를 String으로 반환한다.
	 *
	 * @return
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return response.toString();
	}

	/**
	 * EAI에서 보내준 자료를 반환한다.
	 *
	 * @return
	 */
	public JSONObject getJSONObject() {
		return this.response;
	}

	/**
	 * 사용금지-PMD에서 걸려서 임시로 만듬.
	 *
	 * @param val
	 */
	public void setJSONObject(JSONObject val) {
		this.response = val;
	}

	/**
	 * 단건의 자료를 Map<String, Object>로 반환한다.
	 *
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getMap() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		if (this.response.length() > 1) {
			logger.error("해당 결과는 2건이상을 갖는 구조입니다.");
			// throw new Exception("해당 결과는 2건이상을 갖는 구조입니다.");
		}

		if (!this.isSuccess) {
			logger.error(this.errorMsg);
			// throw new Exception(this.errorMsg);
		}

		Iterator<?> iterator = this.response.keys();

		while (iterator.hasNext()) {
			String key = iterator.next().toString();
			JSONObject data = null;

			try {
				data = this.response.getJSONArray(key).getJSONObject(0);
			} catch (Exception e) {
				data = this.response.getJSONObject(key);
			}

			Iterator<?> dataKeys = data.keys();

			while (dataKeys.hasNext()) {
				String dataKey = dataKeys.next().toString();

				map.put(this.toCamelize(dataKey), String.valueOf(data.get(dataKey)));
			}
		}

		return map;
	}

	/**
	 * 다건의 자료를 List<Map<String, Object>>로 반환한다.
	 *
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getListMap() throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		if (!this.isSuccess) {
			logger.error(this.errorMsg);
			// throw new Exception(this.errorMsg);
		}

		String val = "";

		try {
			val = this.response.getJSONArray("RESULT").toString();
		}
		catch (Exception e) {
			//응답이 다건이지만, 단건으로 넘어오는 경우에는 다건의 자료로 간주하도록 한다.
			val = "["+this.response.getJSONObject("RESULT").toString()+"]";
		}

		try {
			JSONArray resultData = new JSONArray(val); // this.response.getJSONArray("RESULT");

			for (int i = 0; i < resultData.length(); i++) {

				JSONObject data = resultData.getJSONObject(i);

				Iterator<?> id = data.keys();

				Map<String, Object> map = new HashMap<String, Object>();

				while (id.hasNext()) {
					String dataKey = id.next().toString();
					map.put(toCamelize(dataKey), String.valueOf(data.get(dataKey)));
				}

				list.add(map);
			}

			if (resultData.length() < 1) {
				this.isSuccess = false;
				this.errorCode = -1;
				this.errorMsg = "결과가 없습니다.";
			}
		} catch (Exception e) {
			this.isSuccess = false;
			this.errorCode = -1;
			this.errorMsg = "결과가 없습니다.";
		}

		return list;
	}

	/**
	 * 반환되는 결과의 Key를 Camel Case한다.
	 *
	 * @param str
	 * @return
	 */
	private String toCamelize(String str) {
		char[] chars = str.toCharArray();
		boolean nextCharIsUpper = false;
		StringBuffer stringBuffer = new StringBuffer();

		for (char cha : chars) {
			if (cha == '_' || cha == '-') {
				nextCharIsUpper = true;
				continue;
			}

			if (nextCharIsUpper) {
				stringBuffer.append(Character.toUpperCase(cha));
				nextCharIsUpper = false;
			} else {
				stringBuffer.append(Character.toLowerCase(cha));
			}
		}

		return stringBuffer.toString();
	}
}
