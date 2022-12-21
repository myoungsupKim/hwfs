package com.hwfs.fs.fsb.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;
import java.util.Map;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 사업장기준정보 저장권한 관리 UpjangRemainVendorMgntService Interface
 * 
 * @ClassName UpjangRemainVendorMgntService.java
 * @Description UpjangRemainVendorMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.05.20    kihoon        최초생성
 *  
 * </pre>
 * @author 한화시스템/ICT : kihoon
 * @since 2019.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2019 by HANWHA CO.,LTD. All right reserved.
 * </pre>
 */
public interface UpjangRemainVendorMgntService {
	
	/**
	 * 업장 기준정보 권한 목록 조회
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 업장 기준정보 권한 데이터 rowType에 따라 Insert/Update/Delete 처리한다.
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list, LoginDTO loginDTO) throws Exception;
}
