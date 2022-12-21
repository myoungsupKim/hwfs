package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.MenuMgntInqDAO;
import com.hwfs.rc.rrm.dao.SaleEstFrmDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 매출 추정 양식 SaleEstFrm Implementation
 * 
 * @ClassName SaleEstFrmServiceImpl.java
 * @Description SaleEstFrmServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.01.07    김지영        최초생성
 * </pre>
 * @author 김지영
 * @since 2019.01.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Service("/rc/rrm/saleEstFrmService")
public class SaleEstFrmServiceImpl extends DefaultServiceImpl implements SaleEstFrmService
{
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SaleEstFrmDAO Bean 생성 */
	@Resource(name = "/rc/rrm/saleEstFrmDAO")
	private SaleEstFrmDAO saleEstFrmDAO;
	
	/**
	 * 매출 정보 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
			return saleEstFrmDAO.selectList(mapParam);
	}
	
	/**
	 * 월별 단가를 조회한다.
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
	public RecordSet selectMmPriceList(Map<String, Object> mapParam) throws Exception
	{
			return saleEstFrmDAO.selectMmPriceList(mapParam);
	}
	
	/**
	 * 매출 추정 양식 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap mmPrice, DataSetMap list) throws Exception {
		int insMmRowCnt = 0;
		int insDdRowCnt = 0;
		logger.info("chk ::" + mmPrice.size());
		
		//월별 단가 merge
		if(mmPrice.size() > 0)
		{
			Map<String, Object> mmPriceMap = mmPrice.get(0);
			insMmRowCnt += saleEstFrmDAO.insertMmPrice(mmPriceMap);
		}
		
		for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
//            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            
            insDdRowCnt += saleEstFrmDAO.insertDdPrice(rowData);

            //Insert 처리
//            if (rowType == DataSet.ROW_TYPE_INSERTED) {
//                insRowCnt += releaseMgmtDAO.insert(rowData);
//            }
            //Update 처리
//            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
//                updRowCnt += releaseMgmtDAO.update(rowData);
//            }
            
        }
		
		
		
		
		
		/*
		
		//세금계산서 일련번호 생성
		String taxShetNum = (String)taxInvoiceMgntManualDAO.selectTaxShetNum(taxShetMstMap);
		taxShetMstMap.put("taxShetNum", taxShetNum);
		
		//세금계산서 마스터 등록
		insRowCnt = taxInvoiceMgntManualDAO.insertTaxShetMst(taxShetMstMap);
		
		//세금계산서 상세 등록
		for(int i=0; i<taxShetDtl.size(); i++){
			Map<String, Object> rowData = taxShetDtl.get(i);
			rowData.put("taxShetNum", taxShetNum);
			String fiscalDate = (String)taxShetMstMap.get("fiscalDate");
			String itemSupplyDateMM = (String)rowData.get("itemSupplyDateMM");
			String itemSupplyDateDD = (String)rowData.get("itemSupplyDateDD");
			rowData.put("itemSupplyDate", fiscalDate.substring(0, 4)+itemSupplyDateMM+itemSupplyDateDD);
			
			insRowCnt = taxInvoiceMgntManualDAO.insertTaxShetDetail(rowData);
		}*/
		
		return insMmRowCnt + insDdRowCnt;
	}
}