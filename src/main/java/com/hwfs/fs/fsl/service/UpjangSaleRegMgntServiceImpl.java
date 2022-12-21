package com.hwfs.fs.fsl.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fs.fsl.dao.UpjangSaleRegMgntDAO;
import com.hwfs.sc.cmn.util.StringUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 급식의 매출(식권/장례식장 등)을 관리하는 화면이다.하는 UpjangSaleRegMgnt Service Implementation
 * 
 * @ClassName UpjangSaleRegMgntServiceImpl.java
 * @Description UpjangSaleRegMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsl/upjangSaleRegMgntService")
public class UpjangSaleRegMgntServiceImpl extends DefaultServiceImpl implements UpjangSaleRegMgntService {
	
	/** UpjangSaleRegMgntDAO Bean 생성 */
	@Resource(name = "/fs/fsl/upjangSaleRegMgntDAO")
	private UpjangSaleRegMgntDAO upjangSaleRegMgntDAO;
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/**
	 * 매출등록 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectList(Map<String, Object> mapParam) throws Exception {
		RecordSet rs1 = upjangSaleRegMgntDAO.selectList(mapParam);
		RecordSet rs2 = upjangSaleRegMgntDAO.selectListSysClass(mapParam);
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("list", rs1);
		rsMap.put("listSysClass", rs2);
		
		return rsMap;
	}
	
	public Map<String, RecordSet> selectSgList(Map<String, Object> mapParam) throws Exception {
		
		//logger.debug("mapParam : " + mapParam);
		RecordSet rs1 = upjangSaleRegMgntDAO.selectSgList(mapParam);
		//logger.debug("mapParam : " + mapParam);
		RecordSet rs2 = upjangSaleRegMgntDAO.selectSgListStat(mapParam);
		//logger.debug("mapParam : " + mapParam);
		//RecordSet rs3 = upjangSaleRegMgntDAO.selectSgListStat2(mapParam);
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("list", rs1);
		rsMap.put("listStat", rs2);
		//rsMap.put("listStat2", rs3);
		
		return rsMap;
	}
	

	
	/**
	 * 매출등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, DataSetMap listSave, DataSetMap ticket, DataSetMap advanceAmt) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		int ticketRowCnt = 0;
		
		int salAmt = 0;//화면에서 입력한 금액
		int salAmtX = 0;//화면에서 입력한 금액(부가세없음)
		int minusAdvanceAmt = 0; //선수금 가능금액
		int netAmt = 0;
		int sumAmt = 0;//선수금 일반 금액
		// 임시 계산용 변수 : 2015-10-13
		int tempNetAmt = 0;	// 공급가액 계산용 SUM
		int tempVatAmt = 0;	// 부가세 계산용 SUM
		int tempSalAmt = 0;	// 합계 계산용 SUM
		int orgNetAmt = 0;		// Dataset 공급가액 
		int orgVatAmt = 0;		// Dataset 부가세
		int orgSalAmt = 0;		// Dataset 합계금액
		
		String receiptNum = "";
		String tmpSeq = "";
		
		RecordSet rs = null;
		
		//DataSetMap list       -->수정용 데이터셋(현금,외상,카드일때만 식수/단가/매출액/끼니/적요/(매입사/사원) 만 수정가능
		//DataSetMap listSave   -->등록용 데이터셋 
		//DataSetMap ticket     -->식권 저장용 데이터셋
		
		for (int i = 0 ; i < listSave.size() ; i++) {
			Map<String, Object> rowData = listSave.get(i);
			logger.debug("S rowData : " + rowData);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//if(rowData.get("sysClass").toString().equals("11")){//시스템구분 11인것만 저장
			    //payCdNm 세팅
			logger.debug("payCd ========= " + rowData.get("payCd").toString());
				if(rowData.get("payCd").toString().equals("1")){ //현금
					//rowData.put("payCdNm", "현금");
					//evidence 초기화
					rowData.put("evidence1","");
					rowData.put("evidence2","");
					rowData.put("evidence3","");
					rowData.put("evidence4","");
					rowData.put("evidence5","");
					rowData.put("evidence6","");
					
					rowData.put("frncStorNum","");
					rowData.put("cardComCd","");
					rowData.put("buycpnyCd","");
				}else if(rowData.get("payCd").toString().equals("2")){ //카드
					//rowData.put("payCdNm", "카드");
					//evidence 초기화
					rowData.put("evidence1","");
					rowData.put("evidence2","");
					rowData.put("evidence3","");
					rowData.put("evidence4","");
				}else if(rowData.get("payCd").toString().equals("6")){ //타사상품권
					//rowData.put("payCdNm", "타사상품권");
					//evidence 초기화
					rowData.put("evidence3","");
					rowData.put("evidence4","");
					rowData.put("evidence5","");
				}else if(rowData.get("payCd").toString().equals("7")){ //후불(외상)
					//rowData.put("payCdNm", "후불(외상)");
					//evidence 초기화
					rowData.put("evidence3","");
					rowData.put("evidence4","");
					rowData.put("evidence5","");
					rowData.put("evidence6","");
					
					rowData.put("frncStorNum","");
					rowData.put("cardComCd","");
					rowData.put("buycpnyCd","");
				}else if(rowData.get("payCd").toString().equals("8")){ //직원후불
					//rowData.put("payCdNm", "직원후불");
					//evidence 초기화
					rowData.put("evidence2","");
					rowData.put("evidence3","");
					rowData.put("evidence4","");
					rowData.put("evidence5","");
					rowData.put("evidence6","");
					
					rowData.put("frncStorNum","");
					rowData.put("cardComCd","");
					rowData.put("buycpnyCd","");
				}else if(rowData.get("payCd").toString().equals("P1")){ //선수금(일반)
					//rowData.put("payCdNm", "선수금(일반)");
					//evidence 초기화
					rowData.put("evidence1","");
					rowData.put("evidence2","");
					rowData.put("evidence3","");
					rowData.put("evidence4","");
					rowData.put("evidence5","");
					rowData.put("evidence6","");
					
					rowData.put("frncStorNum","");
					rowData.put("cardComCd","");
					rowData.put("buycpnyCd","");
				}else if(rowData.get("payCd").toString().equals("P2")){ //선수금(식권)
					//rowData.put("payCdNm", "선수금(식권)");
					//evidence 초기화
					rowData.put("evidence1","");
					rowData.put("evidence2","");
					rowData.put("evidence3","");
					rowData.put("evidence4","");
					rowData.put("evidence5","");
					rowData.put("evidence6","");
					
					rowData.put("frncStorNum","");
					rowData.put("cardComCd","");
					rowData.put("buycpnyCd","");
				}else if(rowData.get("payCd").toString().equals("P3")){ //외상(식권)
					//rowData.put("payCdNm", "외상(식권)");
					//evidence 초기화
					rowData.put("evidence1","");
					rowData.put("evidence2","");
					rowData.put("evidence3","");
					rowData.put("evidence4","");
					rowData.put("evidence5","");
					rowData.put("evidence6","");
					
					rowData.put("frncStorNum","");
					rowData.put("cardComCd","");
					rowData.put("buycpnyCd","");
				}else if(rowData.get("payCd").toString().equals("Z")){ //내부이용
					//rowData.put("payCdNm", "내부이용");
					//evidence 초기화
					rowData.put("evidence3","");
					rowData.put("evidence4","");
					rowData.put("evidence5","");
					
					rowData.put("frncStorNum","");
					rowData.put("cardComCd","");
					rowData.put("buycpnyCd","");
				}else if(rowData.get("payCd").toString().equals("11")){ //보조금 후불
					//rowData.put("payCdNm", "보조금 후불");
					//evidence 초기화
					rowData.put("evidence3","");
					rowData.put("evidence4","");
					rowData.put("evidence5","");
					rowData.put("evidence6","");
					
					rowData.put("frncStorNum","");
					rowData.put("cardComCd","");
					rowData.put("buycpnyCd","");
				}

				
				if (rowType == DataSet.ROW_TYPE_INSERTED) {//Insert 처리
					//receiptNum 생성
					receiptNum = upjangSaleRegMgntDAO.receiptNum(rowData); 
					rowData.put("receiptNum", receiptNum);

					//--------------------------------------------------------------------------------------------
					// 선수금 정산 관련 Insert 후 화면상에 금액을 GET : 2015-10-13
					orgNetAmt = Integer.parseInt(rowData.get("netAmt").toString()); 
					orgVatAmt = Integer.parseInt(rowData.get("vatAmt").toString()); 
					orgSalAmt = Integer.parseInt(rowData.get("salAmt").toString()); 
					//--------------------------------------------------------------------------------------------
					
//					System.out.println("org NetAmt Param : " + orgNetAmt);
//					System.out.println("org vatAmt Param : " + orgVatAmt);
//					System.out.println("org SalAmt Param : " + orgSalAmt);
					
					////////////////////
					//선수금 선입선출
					////////////////////
					if("P1".equals(rowData.get("payCd").toString())){//선수금 일반
						insRowCnt += upjangSaleRegMgntDAO.mst_insert(rowData);
						logger.debug("선수금일반 등록 ");
						for(int a=0; a<advanceAmt.size(); a++){
							Map<String, Object> rowDataA = advanceAmt.get(a);
							logger.debug("rowDataA : " + rowDataA.toString());
							RecordSet advanceAmtChk = upjangSaleRegMgntDAO.selectAdvanceAmtList(rowDataA);
							if(advanceAmtChk != null && advanceAmtChk.size() > 0){
								logger.debug("sumAmt : " + Integer.parseInt(rowDataA.get("sumAmt").toString()));
								logger.debug("minusAdvanceAmt : " + Integer.parseInt(advanceAmtChk.get(0).get("minusAdvanceAmt").toString()));
								if(Integer.parseInt(rowDataA.get("sumAmt").toString()) > Integer.parseInt(advanceAmtChk.get(0).get("minusAdvanceAmt").toString())){
									throw new BizException("선수금이 변경되어 잔액이 부족합니다.\n\n확인 후 다시 저장해 주세요.");
								}
							}
							
							sumAmt = Integer.parseInt(rowDataA.get("sumAmt").toString());
							rowData.put("seq", a+1);
							rowData.put("salAmt", sumAmt);
							rowData.put("evidence1", rowDataA.get("advanceNum"));
							//부가세가 과세일반 , 면세일반 (부가세0), 영세일반 (부가세 0) 세팅
							if("20".equals(rowData.get("vatClass"))){
								rowData.put("netAmt", Math.round(sumAmt/1.1));//공급가액(총액/1.1)
								netAmt = Integer.parseInt(rowData.get("netAmt").toString());
								rowData.put("vatAmt", sumAmt - netAmt);//부가세금액(매출액 - 공급가)
								
								tempNetAmt += Math.round(sumAmt/1.1);	// 임시 공급가액 SUM : 2015-10-13
								tempVatAmt += sumAmt - netAmt;			// 임시 부가세 SUM	: 2015-10-13
							}else if("43".equals(rowData.get("vatClass"))){
								rowData.put("netAmt", sumAmt);//
								rowData.put("vatAmt", 0);//부가세금액(0)

								//--------------------------------------------------------------------------------------------
								tempNetAmt += sumAmt;	// 임시 공급가액 SUM	: 2105-10-13
								tempVatAmt += 0;			// 임시 부가세 SUM : 2015-10-13
								//--------------------------------------------------------------------------------------------
							}else if("21".equals(rowData.get("vatClass"))){
								rowData.put("netAmt", sumAmt);//
								rowData.put("vatAmt", 0);//부가세금액(0)

								//--------------------------------------------------------------------------------------------
								tempNetAmt += sumAmt;	// 임시 공급가액 SUM : 2015-10-13
								tempVatAmt += 0;			// 임시 부가세 SUM : 2015-10-13
								//--------------------------------------------------------------------------------------------
							}
							insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
						}
						
						//--------------------------------------------------------------------------------------------
						// 2015-10-13 : 선수금일반일 경우 실제 선수금처리 이후 DETAIL 에 공급가, 부가세 재계산(SUM)하여 금액을 반영한다
						tempSalAmt = tempNetAmt + tempVatAmt;
						
						//System.out.println("선수금일반(P1) 처리 START++++++++++++++++++++++++++++++++++++++++++++++");
						//System.out.println("tempSalAmt : " + tempSalAmt );
						//System.out.println("tempNetAmt : " + tempNetAmt );
						//System.out.println("tempVatAmt : " + tempVatAmt );

						// 화면상의 계산된 ORG 공급가액과 실제 처리된 공급가액(SUM)이 다른경우에 계산된 공급가액으로 UPDATE : 2015-10-13
						if ((orgNetAmt != tempNetAmt) &&(orgSalAmt == tempSalAmt)) {
							rowData.put("netAmt",tempNetAmt);
							rowData.put("vatAmt",tempVatAmt);
							rowData.put("salAmt",tempSalAmt);
						} else {
							rowData.put("netAmt",orgNetAmt);
							rowData.put("vatAmt",orgVatAmt);
							rowData.put("salAmt",orgSalAmt);
						}
						//System.out.println("netAmt : " + rowData.get("netAmt").toString() );
						//System.out.println("vatAmt : " + rowData.get("vatAmt").toString() );
						//System.out.println("salAmt : " + rowData.get("salAmt").toString() );
						//System.out.println("선수금일반(P1) 처리  END++++++++++++++++++++++++++++++++++++++++++++++");
						//--------------------------------------------------------------------------------------------
						
						// Detail을 Payment 처리후에 반영한다 : 2015-10-13
						insRowCnt += upjangSaleRegMgntDAO.detail_insert(rowData);
						
						
					}else if("P2".equals(rowData.get("payCd").toString())){//선수식권
						salAmt = Integer.parseInt(rowData.get("salAmt").toString());//화면에서 입력한 금액
						salAmtX = (int) Math.round(salAmt/1.1);//화면에서 입력한 금액(부가세없음)
						if("X".equals(rowData.get("vatClass")) && "Y".equals(rowData.get("taxShetPublishYn"))){//부가세 없음 일때
							rowData.put("salAmt", salAmtX);
							rowData.put("netAmt", salAmtX);//공급가액(총액/1.1)
							rowData.put("vatAmt", 0);//부가세금액(0)
							
							insRowCnt += upjangSaleRegMgntDAO.mst_insert(rowData);
							
							if(salAmtX > 0){
								rs = upjangSaleRegMgntDAO.selectMinusAdvanceAmtTicketP2(rowData);
								
								for(int j=0; j<rs.size(); j++){
									Map<String, Object> rowData2 = rs.get(j);
									minusAdvanceAmt = Integer.parseInt(rowData2.get("minusAdvanceAmt").toString()); //선수금 잔액
									if(salAmtX < minusAdvanceAmt || salAmtX == minusAdvanceAmt){
										rowData.put("seq", i+1);
										rowData.put("salAmt", salAmtX);
										rowData.put("evidence1", rowData2.get("advanceNum"));
										rowData.put("netAmt", salAmtX);//공급가액(총액/1.1)
										rowData.put("vatAmt", 0);//부가세금액(0)
										
										//--------------------------------------------------------------------------------------------
										tempNetAmt += salAmtX;		// 임시 공급가액 SUM : 2015-10-13
										tempVatAmt += 0;				// 임시 부가세 SUM	: 2015-10-13
										//--------------------------------------------------------------------------------------------
										
										insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
										break;
									}	
									
									if(salAmtX > minusAdvanceAmt){
										rowData.put("seq", i+1);
										rowData.put("evidence1", rowData2.get("advanceNum"));
										rowData.put("salAmt", minusAdvanceAmt);
										//부가세가 과세일반 , 면세일반 (부가세0), 영세일반 (부가세 0) 세팅
										//rowData.put("netAmt", Math.round(minusAdvanceAmt/1.1));//공급가액(총액/1.1)
										rowData.put("netAmt", minusAdvanceAmt);//공급가액(총액/1.1)
										rowData.put("vatAmt", 0);//
										
										//--------------------------------------------------------------------------------------------
										tempNetAmt += minusAdvanceAmt;		// 임시 공급가액 SUM : 2015-10-13
										tempVatAmt += 0;								// 임시 부가세 SUM	: 2015-10-13
										//--------------------------------------------------------------------------------------------
																				
										insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
										salAmtX = salAmtX - minusAdvanceAmt ;
									}
								}
							}
							
						}else{
							insRowCnt += upjangSaleRegMgntDAO.mst_insert(rowData);
							
							if(salAmt > 0){
								rs = upjangSaleRegMgntDAO.selectMinusAdvanceAmtTicketP2(rowData);
								
								for(int j=0; j<rs.size(); j++){
									Map<String, Object> rowData2 = rs.get(j);
									minusAdvanceAmt = Integer.parseInt(rowData2.get("minusAdvanceAmt").toString()); //선수금 잔액
									if(salAmt < minusAdvanceAmt || salAmt == minusAdvanceAmt){
										rowData.put("seq", i+1);
										rowData.put("salAmt", salAmt);
										rowData.put("evidence1", rowData2.get("advanceNum"));
										//부가세가 과세일반 , 면세일반 (부가세0), 영세일반 (부가세 0) 세팅
										if("20".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", Math.round(salAmt/1.1));//공급가액(총액/1.1)
											netAmt = Integer.parseInt(rowData.get("netAmt").toString());
											rowData.put("vatAmt", salAmt - netAmt);//부가세금액(매출액 - 공급가)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += netAmt;						// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += salAmt - netAmt;			// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}else if("43".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", salAmt);//
											rowData.put("vatAmt", 0);//부가세금액(0)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += salAmt;						// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += 0;								// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}else if("21".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", salAmt);//
											rowData.put("vatAmt", 0);//부가세금액(0)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += salAmt;						// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += 0;								// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}
										insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
										break;
									}	
									
									if(salAmt > minusAdvanceAmt){
										rowData.put("seq", i+1);
										rowData.put("evidence1", rowData2.get("advanceNum"));
										rowData.put("salAmt", minusAdvanceAmt);
										//부가세가 과세일반 , 면세일반 (부가세0), 영세일반 (부가세 0) 세팅
										if("20".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", Math.round(minusAdvanceAmt/1.1));//공급가액(총액/1.1)
											netAmt = Integer.parseInt(rowData.get("netAmt").toString());
											rowData.put("vatAmt", minusAdvanceAmt - netAmt);//부가세금액(매출액 - 공급가)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += netAmt;									// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += minusAdvanceAmt - netAmt;		// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}else if("43".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", minusAdvanceAmt);//
											rowData.put("vatAmt", 0);//부가세금액(0)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += minusAdvanceAmt;					// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += 0;											// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}else if("21".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", minusAdvanceAmt);//
											rowData.put("vatAmt", 0);//부가세금액(0)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += minusAdvanceAmt;					// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += 0;											// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}
										insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
										salAmt = salAmt - minusAdvanceAmt ;
									}
								}
							}
						}
						
						//--------------------------------------------------------------------------------------------
						// 2015-10-13 : 선수금일반일 경우 실제 선수금처리 이후 DETAIL 에 공급가, 부가세 재계산(SUM)하여 금액을 반영한다
						tempSalAmt = tempNetAmt + tempVatAmt;
						
						//System.out.println("선수식권(P2) 처리 START++++++++++++++++++++++++++++++++++++++++++++++");
						//System.out.println("tempSalAmt : " + tempSalAmt );
						//System.out.println("tempNetAmt : " + tempNetAmt );
						//System.out.println("tempVatAmt : " + tempVatAmt );
						//System.out.println("orgNetAmt : " + orgNetAmt );
						//System.out.println("orgSalAmt : " + orgSalAmt );

						// 화면상의 계산된 ORG 공급가액과 실제 처리된 공급가액(SUM)이 다른경우에 계산된 공급가액으로 UPDATE : 2015-10-13
						if(rowData.get("payCd").toString().equals("P2") && "Y".equals(rowData.get("taxShetPublishYn"))){
							rowData.put("netAmt",tempNetAmt);
							rowData.put("vatAmt",tempVatAmt);
							rowData.put("salAmt",tempSalAmt);
						}else{
							if ((orgNetAmt != tempNetAmt) &&(orgSalAmt == tempSalAmt)) {
								rowData.put("netAmt",tempNetAmt);
								rowData.put("vatAmt",tempVatAmt);
								rowData.put("salAmt",tempSalAmt);
							} else {
								rowData.put("netAmt",orgNetAmt);
								rowData.put("vatAmt",orgVatAmt);
								rowData.put("salAmt",orgSalAmt);
							}
						}
						//System.out.println("netAmt : " + rowData.get("netAmt").toString() );
						//System.out.println("vatAmt : " + rowData.get("vatAmt").toString() );
						//System.out.println("salAmt : " + rowData.get("salAmt").toString() );
						//System.out.println("선수식권(P2) 처리 END++++++++++++++++++++++++++++++++++++++++++++++");
						//--------------------------------------------------------------------------------------------
						// Detail을 Payment 처리후에 반영한다 : 2015-10-13
						insRowCnt += upjangSaleRegMgntDAO.detail_insert(rowData);
						
						
					}else if("P3".equals(rowData.get("payCd").toString())){//외상식권
						salAmt = Integer.parseInt(rowData.get("salAmt").toString());//화면에서 입력한 금액
						salAmtX = (int) Math.round(salAmt/1.1);//화면에서 입력한 금액(부가세없음)
						if("X".equals(rowData.get("vatClass")) || "Y".equals(rowData.get("taxShetPublishYn"))){//부가세 없음 일때
							rowData.put("salAmt", salAmtX);
							rowData.put("netAmt", salAmtX);//공급가액(총액/1.1)
							rowData.put("vatAmt", 0);//부가세금액(0)
							
							insRowCnt += upjangSaleRegMgntDAO.mst_insert(rowData);
							//insRowCnt += upjangSaleRegMgntDAO.detail_insert(rowData);
							if(salAmtX > 0){
								rs = upjangSaleRegMgntDAO.selectMinusAdvanceAmtTicketP3(rowData);
								
								for(int j=0; j<rs.size(); j++){
									Map<String, Object> rowData2 = rs.get(j);
									minusAdvanceAmt = Integer.parseInt(rowData2.get("minusAdvanceAmt").toString()); //선수금 잔액
									if(salAmtX < minusAdvanceAmt || salAmtX == minusAdvanceAmt){
										rowData.put("seq", i+1);
										rowData.put("salAmt", salAmtX);
										rowData.put("evidence1", rowData2.get("advanceNum"));
										rowData.put("netAmt", salAmtX);//공급가액(총액/1.1)
										rowData.put("vatAmt", 0);//부가세금액(0)
										//--------------------------------------------------------------------------------------------
										tempNetAmt += salAmtX;									// 임시 공급가액 SUM : 2015-10-13
										tempVatAmt += 0;											// 임시 부가세 SUM	: 2015-10-13
										//--------------------------------------------------------------------------------------------
										insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
										break;
									}	
									
									if(salAmtX > minusAdvanceAmt){
										rowData.put("seq", i+1);
										rowData.put("evidence1", rowData2.get("advanceNum"));
										rowData.put("salAmt", minusAdvanceAmt);
										//부가세가 과세일반 , 면세일반 (부가세0), 영세일반 (부가세 0) 세팅
										//rowData.put("netAmt", Math.round(minusAdvanceAmt/1.1));//공급가액(총액/1.1)
										rowData.put("netAmt", minusAdvanceAmt);//공급가액(총액/1.1)
										rowData.put("vatAmt", 0);//
										//--------------------------------------------------------------------------------------------
										tempNetAmt += minusAdvanceAmt;					// 임시 공급가액 SUM : 2015-10-13
										tempVatAmt += 0;											// 임시 부가세 SUM	: 2015-10-13
										//--------------------------------------------------------------------------------------------
										insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
										salAmtX = salAmtX - minusAdvanceAmt ;
									}
								}
							}
						}else{
							if(salAmt > 0){
								insRowCnt += upjangSaleRegMgntDAO.mst_insert(rowData);
								//insRowCnt += upjangSaleRegMgntDAO.detail_insert(rowData);
								rs = upjangSaleRegMgntDAO.selectMinusAdvanceAmtTicketP3(rowData);
								
								for(int j=0; j<rs.size(); j++){
									Map<String, Object> rowData2 = rs.get(j);
									minusAdvanceAmt = Integer.parseInt(rowData2.get("minusAdvanceAmt").toString()); //선수금 잔액
									if(salAmt < minusAdvanceAmt || salAmt == minusAdvanceAmt){
										rowData.put("seq", i+1);
										rowData.put("salAmt", salAmt);
										rowData.put("evidence1", rowData2.get("advanceNum"));
										//부가세가 과세일반 , 면세일반 (부가세0), 영세일반 (부가세 0) 세팅
										if("20".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", Math.round(salAmt/1.1));//공급가액(총액/1.1)
											netAmt = Integer.parseInt(rowData.get("netAmt").toString());
											rowData.put("vatAmt", salAmt - netAmt);//부가세금액(매출액 - 공급가)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += netAmt;					// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += salAmt - netAmt;		// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}else if("43".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", salAmt);//
											rowData.put("vatAmt", 0);//부가세금액(0)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += salAmt;					// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += 0;							// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}else if("21".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", salAmt);//
											rowData.put("vatAmt", 0);//부가세금액(0)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += salAmt;					// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += 0;							// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}
										insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
										break;
									}	
									
									if(salAmt > minusAdvanceAmt){
										rowData.put("seq", i+1);
										rowData.put("evidence1", rowData2.get("advanceNum"));
										rowData.put("salAmt", minusAdvanceAmt);
										//부가세가 과세일반 , 면세일반 (부가세0), 영세일반 (부가세 0) 세팅
										if("20".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", Math.round(minusAdvanceAmt/1.1));//공급가액(총액/1.1)
											netAmt = Integer.parseInt(rowData.get("netAmt").toString());
											rowData.put("vatAmt", minusAdvanceAmt - netAmt);//부가세금액(매출액 - 공급가)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += netAmt;										// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += minusAdvanceAmt - netAmt;			// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}else if("43".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", minusAdvanceAmt);//
											rowData.put("vatAmt", 0);//부가세금액(0)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += minusAdvanceAmt;			// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += 0;									// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}else if("21".equals(rowData.get("vatClass"))){
											rowData.put("netAmt", minusAdvanceAmt);//
											rowData.put("vatAmt", 0);//부가세금액(0)
											//--------------------------------------------------------------------------------------------
											tempNetAmt += minusAdvanceAmt;			// 임시 공급가액 SUM : 2015-10-13
											tempVatAmt += 0;									// 임시 부가세 SUM	: 2015-10-13
											//--------------------------------------------------------------------------------------------
										}
										insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
										salAmt = salAmt - minusAdvanceAmt ;
									}
								}
							}
						}
						
						//--------------------------------------------------------------------------------------------
						// 2015-10-13 : 선수금일반일 경우 실제 선수금처리 이후 DETAIL 에 공급가, 부가세 재계산(SUM)하여 금액을 반영한다
						tempSalAmt = tempNetAmt + tempVatAmt;
						
						//System.out.println("외상식권(P3) 처리 START++++++++++++++++++++++++++++++++++++++++++++++");
						//System.out.println("tempSalAmt : " + tempSalAmt );
						//System.out.println("tempNetAmt : " + tempNetAmt );
						//System.out.println("tempVatAmt : " + tempVatAmt );

						// 화면상의 계산된 ORG 공급가액과 실제 처리된 공급가액(SUM)이 다른경우에 계산된 공급가액으로 UPDATE : 2015-10-13
						if(rowData.get("payCd").toString().equals("P3") && "Y".equals(rowData.get("taxShetPublishYn"))){
							rowData.put("netAmt",tempNetAmt);
							rowData.put("vatAmt",tempVatAmt);
							rowData.put("salAmt",tempSalAmt);
						}else{
							if ((orgNetAmt != tempNetAmt) &&(orgSalAmt == tempSalAmt)) {
								rowData.put("netAmt",tempNetAmt);
								rowData.put("vatAmt",tempVatAmt);
								rowData.put("salAmt",tempSalAmt);
							} else {
								rowData.put("netAmt",orgNetAmt);
								rowData.put("vatAmt",orgVatAmt);
								rowData.put("salAmt",orgSalAmt);
							}
						}
						//System.out.println("netAmt : " + rowData.get("netAmt").toString() );
						//System.out.println("vatAmt : " + rowData.get("vatAmt").toString() );
						//System.out.println("salAmt : " + rowData.get("salAmt").toString() );
						//System.out.println("외상식권(P3) 처리 END++++++++++++++++++++++++++++++++++++++++++++++");
						//--------------------------------------------------------------------------------------------
						// Detail을 Payment 처리후에 반영한다 : 2015-10-13
						insRowCnt += upjangSaleRegMgntDAO.detail_insert(rowData);
						
						
					}else{
						insRowCnt += upjangSaleRegMgntDAO.mst_insert(rowData);
						insRowCnt += upjangSaleRegMgntDAO.detail_insert(rowData);
						insRowCnt += upjangSaleRegMgntDAO.payment_insert(rowData);
					}
					
					if(rowData.get("payCd").toString().equals("2")){//카드
						insRowCnt += upjangSaleRegMgntDAO.card_insert(rowData);
					}
					tmpSeq = rowData.get("tmpSeq").toString();
					receiptNum = rowData.get("receiptNum").toString();
					// 식권 판매 매출 저장 mas_ticket_mst
					ticketRowCnt= ticketSave(ticket, receiptNum, tmpSeq);
				}
			//}	
				logger.debug("E rowData : " + rowData);

				logger.debug("건별등록 프로시저 호출");
				/*
				if("P2".equals(rowData.get("payCd").toString()) || "P3".equals(rowData.get("payCd").toString())){
					
					int ticketCnt = upjangSaleRegMgntDAO.selectTicketMst(rowData);
					if(ticketCnt > 0){
						throw new BizException("이후에 판매된 식권이존재하여 입력 할 수 없습니다.");
					}
					
					logger.debug("건별등록 프로시저 호출");
				}
				*/
				logger.debug("rowData I/F 전 : " + rowData.toString());
				if("A".equals(nvls(rowData.get("modifySalsYn")))){
					Map<String, Object> pMap = new HashMap<String, Object>();
					pMap.put("p_occur_date", 	  	String.valueOf(rowData.get("occurDate"))); //매출일자
					pMap.put("p_sys_class", 	  	String.valueOf("11")); //SYS_CLASS
					pMap.put("p_upjang_cd",  		String.valueOf(rowData.get("upjangCd"))); //업장
					pMap.put("p_receipt_num", 		String.valueOf(rowData.get("receiptNum"))); //영수증 번호
					rowData = upjangSaleRegMgntDAO.recepitModify(pMap , "SP_SLA_SALS_POS_RECEIPT_PROC");
					logger.debug("rowData I/F 후 : " + rowData.toString());
					if(!"TRUE".equals(rowData.get("O_RTN").toString())){
						throw new BizException(rowData.get("O_RTNMSG").toString());
					}
				}
		}
		
		
		///////////////////////////////////////////////////////////////////////
		//수정용 데이터셋(현금,외상,카드일때만 식수/단가/매출액/끼니/적요/(매입사/사원) 만 수정가능
		/////////////////////////////////////////////////////////////////////
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//if(rowData.get("sysClass").toString().equals("11")){//시스템구분 11인것만 저장
				if (rowType == DataSet.ROW_TYPE_UPDATED) {//Update 처리
					logger.debug("Upd_rowData : " + rowData);
					if(!rowData.get("payCd").toString().equals("P1") && !rowData.get("payCd").toString().equals("P2") && !rowData.get("payCd").toString().equals("P3")){
						updRowCnt += upjangSaleRegMgntDAO.mst_update(rowData);
						updRowCnt += upjangSaleRegMgntDAO.detail_update(rowData);
						updRowCnt += upjangSaleRegMgntDAO.payment_update(rowData);
					}
					if(rowData.get("payCd").toString().equals("2")){//카드
						delRowCnt += upjangSaleRegMgntDAO.card_update(rowData);//카드 등록
						delRowCnt += upjangSaleRegMgntDAO.ticket_delete(rowData);//식권 삭제
					}else if(rowData.get("payCd").toString().equals("P1")){//식권 팝업 저장 이므로..다른 유형만 삭제
						delRowCnt += upjangSaleRegMgntDAO.card_delete(rowData);//카드 삭제
					}
				}
				else if (rowType == DataSet.ROW_TYPE_DELETED) {//Delete 처리
					logger.debug("Del_rowData : " + rowData);
					//마감데이터가 삭제된 경우 프로시저 호출
					if("Y".equals(nvls(rowData.get("ddddCloseYn")))){
						/*
						if("P2".equals(rowData.get("payCd").toString()) || "P3".equals(rowData.get("payCd").toString())){
							
							int ticketCnt = upjangSaleRegMgntDAO.selectTicketMst(rowData);
							if(ticketCnt > 0){
								throw new BizException("이후에 판매된 식권이존재하여 삭제할 수 없습니다.");
							}
							
						}
						*/
						logger.debug("건별삭제 프로시저 호출");
						logger.debug("rowData I/F 전 : " + rowData.toString());
						Map<String, Object> pMap = new HashMap<String, Object>();
						pMap.put("p_occur_date", 	  	String.valueOf(rowData.get("occurDate"))); //매출일자
						pMap.put("p_sys_class", 	  	String.valueOf("11")); //SYS_CLASS
						pMap.put("p_upjang_cd",  		String.valueOf(rowData.get("upjangCd"))); //업장
						pMap.put("p_receipt_num", 		String.valueOf(rowData.get("receiptNum"))); //영수증 번호
						rowData = upjangSaleRegMgntDAO.recepitModify(pMap ,"SP_SLA_SALS_POS_RECEIPT_CANCEL");
						logger.debug("rowData I/F 후 : " + rowData.toString());
						if(!"TRUE".equals(rowData.get("O_RTN").toString())){
							throw new BizException(rowData.get("O_RTNMSG").toString());
						}
					}else{
						//마감이 아닌경우
						delRowCnt += upjangSaleRegMgntDAO.mst_delete(rowData);
						delRowCnt += upjangSaleRegMgntDAO.detail_delete(rowData);
						if(rowData.get("payCd").toString().equals("P1") || rowData.get("payCd").toString().equals("P2")){
							delRowCnt += upjangSaleRegMgntDAO.paymentAdvance_delete(rowData);
						}else{
							delRowCnt += upjangSaleRegMgntDAO.payment_delete(rowData);
						}
					
						//카드정보
						delRowCnt += upjangSaleRegMgntDAO.card_delete(rowData);
						//식권
						delRowCnt += upjangSaleRegMgntDAO.ticket_delete(rowData);
					}
				}
			//}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 매출등록 식권 데이터를 rowType에 따라 Insert 처리한다.
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
	public int ticketSave(DataSetMap list, String receiptNum, String tmpSeq) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String ticketMstGroupSeq = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if(tmpSeq.equals(rowData.get("tmpSeq").toString())){
				if("".equals(ticketMstGroupSeq)){
					ticketMstGroupSeq = upjangSaleRegMgntDAO.ticketMstGroupSeq(rowData);
				}
				
				//영수증 번호 조회
				rowData.put("receiptNum", receiptNum);
				rowData.put("ticketGroupSeq", ticketMstGroupSeq);
				insRowCnt += upjangSaleRegMgntDAO.ticket_insert(rowData);
			}
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 업장 CC_CD를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjangCcCdInfo(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.selectUpjangCcCdInfo(mapParam);
	}
	
	/**
	 * 식권팝업용 번호를  생성한다
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTmpSeq(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.selectTmpSeq(mapParam);
	}
	
	
	/**
	 * 창고 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet posClassList(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.posClassList(mapParam);
	}
	
	/**
	 * 회수예정일을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectExpDt(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.selectExpDt(mapParam);
	}
	
	/**
	 * 마감체크를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet beforeDt(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.dtCnt(mapParam);
	}
	
	/**
	 * 마감체크(전일자)를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet beforeDt2(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.dtCnt2(mapParam);
	}
	
	/**
	 * 전일자 마감체크를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet beforeDtCopy(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.dtCntCopy(mapParam);
	}
	
	/**
	 * 상품권 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet evCnt(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.evCnt(mapParam);
	}
	
	/**
	 * 선수금잔액합계를 조회한다(선수식권)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSumAdvanceAmtTicketP2(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.selectSumAdvanceAmtTicketP2(mapParam);
	}
	
	/**
	 * 선수금잔액합계를 조회한다(외상식권)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSumAdvanceAmtTicketP3(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.selectSumAdvanceAmtTicketP3(mapParam);
	}
	
	/**
	 * 건별권한을 갖기위한 기획자 승인여부 
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCloseModifyreq(Map<String, Object> mapParam) throws Exception {
		logger.debug(mapParam.toString());
		return upjangSaleRegMgntDAO.selectCloseModifyreq(mapParam);
	}
	
	/**
	 * 사업장별 오픈일자 가져오기 
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectOpenDate(Map<String, Object> mapParam) throws Exception {
		return upjangSaleRegMgntDAO.selectOpenDate(mapParam);
	}
	
	public String nvls(Object col) throws Exception{
		if(col == null)
			return "";
		else
			return StringUtil.null2string(col.toString(), "");
	}
	

}