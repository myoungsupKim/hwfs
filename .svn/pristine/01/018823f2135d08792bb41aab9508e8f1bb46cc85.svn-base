package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsl.dao.UpjangSaleRegMgntCopyDAO;

 /***
 * 매출등록 카피하는 UpjangSaleRegMgntCopy Service Implementation
 * 
 * @ClassName UpjangSaleRegMgntCopyServiceImpl.java
 * @Description UpjangSaleRegMgntCopyServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.28    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통협영업 손형민
 * @since 2015.05.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsl/upjangSaleRegMgntCopyService")
public class UpjangSaleRegMgntCopyServiceImpl extends DefaultServiceImpl implements UpjangSaleRegMgntCopyService {
	

	/** UpjangSaleRegMgntCopyDAO Bean 생성 */
	@Resource(name = "/fs/fsl/upjangSaleRegMgntCopyDAO")
	private UpjangSaleRegMgntCopyDAO upjangSaleRegMgntCopyDAO;
	

	/**
	 * 매출등록 카피 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveList(Map<String, Object> mapParam) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		RecordSet rs = upjangSaleRegMgntCopyDAO.selectMst(mapParam);
		if(rs.size() == 0){
			return -2;
		}
		for(int i=0; i < rs.size() ; i ++){
			mapParam.put("receiptNum", rs.get(i).getString("receiptNum"));
			mapParam.put("newReceiptNum", upjangSaleRegMgntCopyDAO.createReceiptNum(mapParam));
			/** MST 마스터 등록 **/
			insRowCnt += upjangSaleRegMgntCopyDAO.copyMst(mapParam);
			
			/** DETAIL 등록 **/
			insRowCnt += upjangSaleRegMgntCopyDAO.copyDetail(mapParam);
			
			/** PAYMENT 등록 **/
			insRowCnt += upjangSaleRegMgntCopyDAO.copyPayment(mapParam);
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
