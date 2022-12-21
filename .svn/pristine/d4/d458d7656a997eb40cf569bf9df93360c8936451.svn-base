package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fms.dao.SalePriceAutoCreateDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 식자재영업 표준단가 생성하는 SalePriceAutoCreate Service Implementation
 * 
 * @ClassName SalePriceAutoCreateServiceImpl.java
 * @Description SalePriceAutoCreateServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.31
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/salePriceAutoCreateService")
public class SalePriceAutoCreateServiceImpl extends DefaultServiceImpl implements SalePriceAutoCreateService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SalePriceAutoCreateDAO Bean 생성 */
	@Resource(name = "/fm/fms/salePriceAutoCreateDAO")
	private SalePriceAutoCreateDAO salePriceAutoCreateDAO;
	

	/**
	 * 식자재영업 표준단가 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return salePriceAutoCreateDAO.selectList(mapParam);
	}

	/**
	 * 식자재영업 납품업체 거래처를 조회한다.(팝업)
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCust(Map<String, Object> mapParam) throws Exception {
		return salePriceAutoCreateDAO.selectCust(mapParam);
	}
	
	/**
	 * 단가이력을 조회한다.(팝업)
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectHist(Map<String, Object> mapParam) throws Exception {
		return salePriceAutoCreateDAO.selectHist(mapParam);
	}

	/**
	 * contract id 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectContractId(Map<String, Object> mapParam) throws Exception {
		return salePriceAutoCreateDAO.selectContractId(mapParam);
	}
	
	/**
	 * 조건에 해당하는 단가정보 여부를 조회한다
	 * <pre>
	 * </pre>
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int selectPriceCnt(DataSetMap list) throws Exception {
		int selRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			selRowCnt += salePriceAutoCreateDAO.selectPriceCnt(rowData);
		}
		
		return selRowCnt;
	}
	
	
	/**
	 * 식자재영업 표준단가 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		int updRowCnt = 0;
		String msg = "";			// 처리결과 문구
		RecordSet rs = null;
		String contractId = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			// 실제 INSERT 부분만 실행 하게됨 : 단가생성일자에 자료가 있으면 PASS 함(현재)
			insRowCnt += salePriceAutoCreateDAO.insert(rowData);
			logger.debug("########## insRowCnt = "+insRowCnt+" ##########");
			// 단가 생성 후 PO_CONTRACT_FSALE 의 종료일자 UPDATE
			if (insRowCnt > 0) {
				// 생성된 자재를 기준으로 이전_종료일자 SET
				//salePriceAutoCreateDAO.updateDate(rowData);
				
				// 생성된 자재이외에 자료들에 대해 종료일자 SET
				//salePriceAutoCreateDAO.updateDateNon(rowData);
				// 이전 계약번호에 대한 전제단가정보의 종료일자를 UPDATE한다(08-05)
				rs = salePriceAutoCreateDAO.selectContractId(rowData);
				logger.debug("########## rs.size() = "+rs.size()+" ##########");
				if( rs.size() == 0 )
				{
					throw new BizException("판매단가자동생성 중 오류가 발생했습니다.[ 계약정보조회오류 ]");
				}
				
				contractId = rs.get(0).getString("contractId");
				rowData.put("contractId", contractId);
				logger.debug(contractId);
				updRowCnt = salePriceAutoCreateDAO.updateDate3(rowData);

				if( updRowCnt == 0 )
				{
					//throw new BizException("판매단가자동생성 중 오류가 발생했습니다.[" + contractId +"]");
				}
				
				logger.debug("########## updRowCnt = "+updRowCnt+" ##########");
				// 생성결과를 반영한다
				msg = insRowCnt + "건 단가생성완료 ";
				msg = msg + "시작일자(";
				msg = msg + rowData.get("stdDate").toString().substring(0, 4);
				msg = msg + "-" + rowData.get("stdDate").toString().substring(4, 6);
				msg = msg + "-" + rowData.get("stdDate").toString().substring(6, 8);
				msg = msg + ")";
				
				// 처리결과 SET
				rowData.put("msg", msg);
				
				// UPDATE 처리 호출
				salePriceAutoCreateDAO.updateMsg(rowData);
			}
			
		}
				
		return insRowCnt;
	}
}
