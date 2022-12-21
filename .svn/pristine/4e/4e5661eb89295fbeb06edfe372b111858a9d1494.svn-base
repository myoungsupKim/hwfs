package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.ArMstProcessDAO;
import com.hwfs.sm.sar.dao.GiftWithdrawActualDAO;
import com.hwfs.sm.ssi.dao.GiftTypeMgntDAO;
import com.hwfs.sm.cmn.dao.CommonDAO;
import com.tobesoft.xplatform.data.DataSet;
import com.hwfs.sm.sar.dao.SaleCashAlterDAO;

 /**
 * 상품권회수 실적관리하는 GiftWithdrawActual Service Implementation
 * 
 * @ClassName GiftWithdrawActualServiceImpl.java
 * @Description GiftWithdrawActualServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/giftWithdrawActualService")
public class GiftWithdrawActualServiceImpl extends DefaultServiceImpl implements GiftWithdrawActualService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** GiftWithdrawActualDAO Bean 생성 */
	@Resource(name = "/sm/sar/giftWithdrawActualDAO")
	private GiftWithdrawActualDAO giftWithdrawActualDAO;
	
	/** CommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/commonDAO")
	private CommonDAO commonDAO;
	
	/** ArMstProcessDAO Bean 생성 */
	@Resource(name = "/sm/sar/arMstProcessDAO")
	private ArMstProcessDAO arMstProcessDAO;	
	
	/** GiftTypeMgntDAO Bean 생성 */
	@Resource(name = "/sm/ssi/giftTypeMgntDAO")
	private GiftTypeMgntDAO giftTypeMgntDAO;
		
	/** SaleCashAlterDAO Bean 생성 */
	@Resource(name = "/sm/sar/saleCashAlterDAO")
	private SaleCashAlterDAO saleCashAlterDAO;	

	/**
	 * 상품권회수 실적관리 목록을 조회한다.
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
		return giftWithdrawActualDAO.selectList(mapParam);
	}
	/**
	 * 상품권회수 여부를 조회한다.
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
	
	public RecordSet selectGiftNum(Map<String, Object> mapParam) throws Exception {
		return giftWithdrawActualDAO.selectGiftNum(mapParam);
	}


	/**
	 * 상품권회수 실적관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		
		int iExchAmt = 0;
		
		String maxArNum;
		String maxSalesCashNum = "";   //현금의 경우 영업현금발생
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//채권 생성
			Map<String, Object> newArData = new HashMap();
			
			newArData.put("occurDate", rowData.get("occurDate"));
			
			newArData.put("fiscalDate", rowData.get("occurDate"));	
			
			newArData.put("arOccurClass", "AO04");		//채권발생구분	- 부서이관
			
			newArData.put("arAmt", rowData.get("giftAmt"));		//채권금액
			newArData.put("remark", rowData.get("remark"));		//비고
			newArData.put("acctCd", rowData.get("acctCd"));		//비고
			newArData.put("custCd", rowData.get("custCd"));		//이관거래처
			newArData.put("custNm", rowData.get("custNm"));		//이관 거래처명
			newArData.put("ccCd", rowData.get("ccCd"));		//CC코드
			newArData.put("muCd", rowData.get("muCd"));		//사업부
			newArData.put("taxShetPublishYn", "N");
			newArData.put("upjangCd", rowData.get("upjangCd"));      //업장
			newArData.put("payClassCd", "6");      //업장
			newArData.put("arTypeCd", "A04");      //업장
			newArData.put("receiptNum", rowData.get("receiptNum"));      //업장
			newArData.put("sysClass", rowData.get("sysClass"));      //업장
			newArData.put("arNum", rowData.get("arNum"));      //업장
			
			iExchAmt = 0;
			//Integer.parseInt(
			iExchAmt = Integer.parseInt(rowData.get("giftAmt").toString()) - Integer.parseInt(rowData.get("useAmt").toString());
					
//			rowData.put("arNum", "0");
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				RecordSet rsUpjang = commonDAO.getUpjangCd(rowData);
				
				RecordSet giftKindRs = giftTypeMgntDAO.selectList(rowData);
				
				Map<String,Object> upjangMap = rsUpjang.get(0);
				
				maxArNum =  arMstProcessDAO.selectMaxArNum(newArData);
				newArData.put("arNum", maxArNum);		//새로운 채권번호
				newArData.put("upjangCd", upjangMap.get("upjang"));      //업장
				newArData.put("acctCd", giftKindRs.get(0).getString("occurAcctCd"));      //업장
				newArData.put("custCd", giftKindRs.get(0).getString("custCd"));      //업장
				
				updRowCnt += arMstProcessDAO.insert(newArData);				
				
				
				rowData.put("upjangCd", upjangMap.get("upjang"));
				rowData.put("recdStatus", "L");
				rowData.put("arNum", maxArNum);
				rowData.put("occurArCreationYn", "Y");
				rowData.put("acctCd", giftKindRs.get(0).getString("occurAcctCd"));
				
				if ("002".equals(giftKindRs.get(0).getString("arTypeCd"))){
					if(iExchAmt != 0){
						maxSalesCashNum = saleCashAlterDAO.selectMaxSalesCashNum(rowData);
						rowData.put("exchAmt", iExchAmt);
		                rowData.put("salesCashNum", maxSalesCashNum);
					}
	                
				}
				
				insRowCnt += giftWithdrawActualDAO.insert(rowData);
				
				//현금인 경우는 영업현금 발생
				if ("002".equals(rowData.get("arTypeCd"))){
					if(iExchAmt != 0){
		                rowData.put("maxSalesCashNum", maxSalesCashNum);
		                //if(rowData.get("upjangCd").equals("114356") || rowData.get("ccCd").equals("315160")){	//티원서울은 현금_사업장환전금 계정 사용
		                //전업장 사업장환불금 계정 사용
		                	rowData.put("acctCd", "11101014");
		                //}else{
		                //	rowData.put("acctCd", "11101012");		                	
		                //}
		                rowData.put("occurAmt", iExchAmt * -1);
		                rowData.put("modifySalsYn", "N");               //데이타구분 "N" :정상분  "Y":조정분
		                rowData.put("remark"   , "상품권 거스름돈");               //자동수기구분  "C":자동  "A":수기발생
		                rowData.put("dataClass"   , "A");               //자동수기구분  "C":자동  "A":수기발생
		                rowData.put("cashOccurClass"   , "CH02");               //자동수기구분  "C":자동  "A":수기발생
						insRowCnt += saleCashAlterDAO.insertSaleCash(rowData);
					}
				}				
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += arMstProcessDAO.update(newArData);
				
				//거스름돈이 있는지 체크
				if ("".equals(rowData.get("salesCashNum"))){
					if ("002".equals(rowData.get("arTypeCd"))){
						if(iExchAmt != 0){
							maxSalesCashNum = saleCashAlterDAO.selectMaxSalesCashNum(rowData);
							rowData.put("exchAmt", iExchAmt);
			                rowData.put("salesCashNum", maxSalesCashNum);

			                rowData.put("maxSalesCashNum", maxSalesCashNum);
			                //if(rowData.get("upjangCd").equals("114356") || rowData.get("ccCd").equals("315160")){	//티원서울은 현금_사업장환전금 계정 사용
			                //전업장 사업장환불금 계정 사용
			                	rowData.put("acctCd", "11101014");
			                //}else{
			                //	rowData.put("acctCd", "11101012");		                	
			                //}
			                rowData.put("occurAmt", iExchAmt * -1);
			                rowData.put("modifySalsYn", "N");               //데이타구분 "N" :정상분  "Y":조정분
			                rowData.put("remark"   , "상품권 거스름돈");               //자동수기구분  "C":자동  "A":수기발생
			                rowData.put("dataClass"   , "A");               //자동수기구분  "C":자동  "A":수기발생
			                rowData.put("cashOccurClass"   , "CH02");               //자동수기구분  "C":자동  "A":수기발생
							insRowCnt += saleCashAlterDAO.insertSaleCash(rowData);
						}
					}	
				}else{
					rowData.put("exchAmt", iExchAmt);
					rowData.put("occurAmt", iExchAmt * -1);
					updRowCnt += saleCashAlterDAO.deleteSaleCash(rowData);
				}				
				updRowCnt += giftWithdrawActualDAO.update(rowData);
				
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				updRowCnt += arMstProcessDAO.cancelArMst(newArData);
				delRowCnt += giftWithdrawActualDAO.delete(rowData);
				
				if (!"".equals(rowData.get("salesCashNum"))){
					rowData.put("recdStatus", "D");
					delRowCnt += saleCashAlterDAO.deleteSaleCash(rowData);					
				}
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
