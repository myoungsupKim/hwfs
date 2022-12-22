package com.hwfs.ms.mwr.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.mwr.dao.ProvisionalContractReqtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 가계약(연회/웨딩)등록하는 ProvisionalContractReqt Service Implementation
 * 
 * @ClassName ProvisionalContractReqtServiceImpl.java
 * @Description ProvisionalContractReqtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mwr/provisionalContractReqtService")
public class ProvisionalContractReqtServiceImpl extends DefaultServiceImpl implements ProvisionalContractReqtService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ProvisionalContractReqtDAO Bean 생성 */
	@Resource(name = "/ms/mwr/provisionalContractReqtDAO")
	private ProvisionalContractReqtDAO provisionalContractReqtDAO;
	

	/**
	 * 가계약(연회/웨딩)등록 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return provisionalContractReqtDAO.selectList(mapParam);
	}

	/**
	 * 가계약(연회/웨딩)등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int insRowFunctionCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//일련번호를 채번한다(YYYYMMXXXXX(11자리: 년월(6)+일련번호(5))
			RecordSet reservNumList = provisionalContractReqtDAO.selectReservNum(rowData);
			
			String reservNum = (String) reservNumList.get(i).get("reservNum");
			
			//채번한 일련번호를 예약번호에 담는다.
			rowData.put("reservNum", reservNum);			
			
			logger.debug("log >>>>>>>>>>>>" +rowData);
			
			//가계약(연회/웨딩)내용을 마스터 테이블에 등록한다.
			insRowCnt += provisionalContractReqtDAO.insertMst(rowData);
			
			//예약번호, 행사구분(연회:1, 웨딩:2, 케이터링:3)내용을 BMS_FUNCTION 테이블에 등록한다.
			insRowFunctionCnt += provisionalContractReqtDAO.insertBmsFunction(rowData);		
			
		}
				
		return insRowCnt;
	}
}
