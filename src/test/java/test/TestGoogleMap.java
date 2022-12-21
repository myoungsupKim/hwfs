package test;

import java.util.List;

import com.hwfs.sc.cmn.dto.GoogleMapDTO;
import com.hwfs.sc.cmn.util.GoogleMapUtil;

 /**
 * GoogleMap Api
 * @ClassName TestGoogleMap.java
 * @Description TestGoogleMap Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 24.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 2. 11.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class TestGoogleMap {

	/**
	 * GoogleMap 테스트
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param args
	 */
	public static void main(String[] args) {
		try {
			String strAddress = "경기도산본동252-15";
			
			GoogleMapDTO  googleMapDTO = GoogleMapUtil.getGoolgleMapInfo (strAddress);
			System.out.println (googleMapDTO.toString());
			
			String[] arrAddress = new String[] {"경기도산본동252-15", "서울특별시 노원구 상계8동 887-7 서울동일초등학교"};
			List<GoogleMapDTO>  googleMapList = GoogleMapUtil.getGoolgleMapInfo (arrAddress);
			System.out.println (googleMapList.toString());
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
