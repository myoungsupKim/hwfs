package com.hwfs.sc.scp.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 개인정보 파기이력을 관리하는 PersDstryHist Service Interface
 * 
 * @ClassName PersDstryHistService.java
 * @Description PersDstryHistService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    kksoo        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PersDstryHistService {

	/**
	 * 개인정보 파기이력 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 개인정보 파기이력 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
	
	/**
	 * 사용자 지속이용 표명으로 인한 개인정보 파기통보 건을 취소처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	int cancelDstryNoti(Map<String, Object> mapParam) throws Exception;
}
