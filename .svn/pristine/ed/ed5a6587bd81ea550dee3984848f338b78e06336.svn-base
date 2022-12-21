package com.hwfs.sc.cmn.util;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

import com.hwfs.cmn.util.HttpURLConnectionUtil;
import com.hwfs.sc.cmn.dto.GoogleMapDTO;

/**
 * 프로젝트에서 공통으로 사용하는 GoogleMap Utility
 * @ClassName GoogleMapUtil.java
 * @Description GoogleMapUtil Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 24.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 4. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class GoogleMapUtil {

	/** Google Map API 주소 */
	private static final String GOOGLE_MAPS_API = "http://maps.google.com/maps/api/geocode/json";
	
	/**
	 * 한글주소에 대한 구글맵의 위도, 경도 주소를 얻는다.
	 *
	 * @param strAddress 한글주소
	 * @return GoogleMapDTO
	 */
	public static GoogleMapDTO getGoolgleMapInfo (String strAddress) {
		try {
			//Google Map API를 호출하여 결과를 JsonObject로 받는다.
			String strUrl = String.format("%s?address=%s&language=ko", GOOGLE_MAPS_API, java.net.URLEncoder.encode(strAddress, "UTF-8"));
			String strResult = HttpURLConnectionUtil.getURLBufferedReader(strUrl, "");
			JSONObject jsonResult = new JSONObject (strResult);

			//결과를 DTO로 변환한다. 
			JSONObject jsonInfo = jsonResult.getJSONArray("results").getJSONObject(0);
			
			GoogleMapDTO googleMapDTO = new GoogleMapDTO ();
			googleMapDTO.setAddress(strAddress);																//요청주소
			googleMapDTO.setStatus(jsonResult.getString("status"));												//상태 (OK이면 정상)
			googleMapDTO.setFormattedAddress(jsonInfo.getString("formatted_address"));							//변환된 주소
			googleMapDTO.setLat(jsonInfo.getJSONObject("geometry").getJSONObject("location").getString("lat"));	//위도
			googleMapDTO.setLng(jsonInfo.getJSONObject("geometry").getJSONObject("location").getString("lng"));	//경도
			
			return googleMapDTO;
		} catch (Exception e) {
			GoogleMapDTO googleMapDTO = new GoogleMapDTO ();
			googleMapDTO.setAddress(strAddress);
			googleMapDTO.setStatus("FAIL");
			return googleMapDTO;
		}
	}

	/**
	 * 한글주소에 대한 구글맵의 위도, 경도 주소를 얻는다.
	 *
	 * @param arrAddress 한글주소배열
	 * @return List<GoogleMapDTO>
	 */
	public static List<GoogleMapDTO> getGoolgleMapInfo (String[] arrAddress) {
		List<GoogleMapDTO> list = new ArrayList<GoogleMapDTO>();
		
		for (int i=0; i<arrAddress.length; i++) {
			list.add(getGoolgleMapInfo(arrAddress[i]));
		}
		
		return list;
	}

}
