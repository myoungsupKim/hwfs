package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 급식의 매출(식권/장례식장 등)을 관리하는 화면이다.하는 UpjangSaleRegMgnt Service Interface
 * 
 * @ClassName UpjangSaleRegMgntService.java
 * @Description UpjangSaleRegMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    손형민        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface UpjangSaleRegMgntService {

	/**
	 * 식권팝업용 번호를  생성한다
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	Map<String, RecordSet> selectList(Map<String, Object> mapParam) throws Exception;
	Map<String, RecordSet> selectSgList(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectTmpSeq(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 업장 CC_CD를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUpjangCcCdInfo(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 매출등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list, DataSetMap listSave, DataSetMap ticket, DataSetMap advanceAmt) throws Exception;
	
	/**
	 * 창고 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet posClassList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 회수예정일을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectExpDt(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 마감체크를 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	RecordSet beforeDt(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 마감체크(전일자)를 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	RecordSet beforeDt2(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 전일자 마감체크를 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	RecordSet beforeDtCopy(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 상품권 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	RecordSet evCnt(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 선수금잔액합계를 조회한다(선수식권)
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	RecordSet selectSumAdvanceAmtTicketP2(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 선수금잔액합계를 조회한다(외상식권)
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	RecordSet selectSumAdvanceAmtTicketP3(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 건별권한을 갖기위한 기획자 승인여부 
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	RecordSet selectCloseModifyreq(Map<String, Object> mapParam) throws Exception;

	/**
	 * 사업장별 오픈일자 가져오기 
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	RecordSet selectOpenDate(Map<String, Object> mapParam) throws Exception;
	
}
