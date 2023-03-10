package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 클레임요청하는 ClaimReg Service Interface
 * 
 * @ClassName ClaimRegService.java
 * @Description ClaimRegService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    최영준        최초생성
 *  2015.07.13	  손형민		인수인계
 *  2021.08.09    DEV02         [PJT]주문채널통합
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ClaimRegService {
	
	/**
	 * 업장별 창고리스트 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 클레임요청 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 클레임요청 목록을 조회한다.
	 * [PJT]주문채널통합
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectBrandList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 공통코드 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet commonList(Map <String, Object> parm) throws Exception;
	
	/**
	 * PC사진 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectPC(Map<String, Object> inVar) throws Exception;
	
	/**
	 * Mobile사진 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectMobile(Map<String, Object> inVar) throws Exception;
	
	/**
	 * 자재별 재고량 확인.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	Map <String, Object> ItemQty(DataSetMap list) throws Exception;
	/**
	 * 클레임요청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
	
	/**
	 * 모바일에서 첫번째로 저장시 클레임 사진정보 저장
	 *
	 * @param list, FileId
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveFileId(DataSetMap list, String strRefSeq) throws Exception;	
	
	String saveAttachFile(DataSetMap list, DataSetMap listFile) throws Exception;	
	
	String save(DataSetMap listFile, String relPath, boolean encYn, boolean webRepoYn, boolean useOrgnlNmYn, String seq) throws Exception;
	
}
