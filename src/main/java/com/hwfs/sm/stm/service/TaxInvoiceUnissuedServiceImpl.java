package com.hwfs.sm.stm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.stm.dao.TaxInvoiceUnissuedDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 세금계산서 미발행하는 TaxInvoiceUnissued Service Implementation
 * 
 * @ClassName TaxInvoiceUnissuedServiceImpl.java
 * @Description TaxInvoiceUnissuedServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.25    남유민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 남유민
 * @since 2015.08.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/stm/taxInvoiceUnissuedService")
public class TaxInvoiceUnissuedServiceImpl extends DefaultServiceImpl implements TaxInvoiceUnissuedService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TaxInvoiceUnissuedDAO Bean 생성 */
	@Resource(name = "/sm/stm/taxInvoiceUnissuedDAO")
	private TaxInvoiceUnissuedDAO taxInvoiceUnissuedDAO;
	

	/**
	 * 세금계산서 미발행 목록을 조회한다.
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
		
		String occurClass = (String)mapParam.get("inqueryOccurClass");
		
		if(occurClass.equals("1") || occurClass.equals("2")){
			return taxInvoiceUnissuedDAO.selectArList(mapParam);			//채권
		}else if(occurClass.equals("3") || occurClass.equals("4")){
			return taxInvoiceUnissuedDAO.selectAdvanceList(mapParam);	//선수금
		}
		return taxInvoiceUnissuedDAO.selectSalsList(mapParam);			//매출
	}

	/**
	 * 세금계산서 미발행 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += taxInvoiceUnissuedDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += taxInvoiceUnissuedDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += taxInvoiceUnissuedDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
