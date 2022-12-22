package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.srm.dao.SapSlipUploadDAO;

 /**
 * SAP 전표 업로드하는 SapSlipUpload Service Implementation
 * 
 * @ClassName SapSlipUploadServiceImpl.java
 * @Description SapSlipUploadServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/srm/sapSlipUploadService")
public class SapSlipUploadServiceImpl extends DefaultServiceImpl implements SapSlipUploadService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapSlipUploadDAO Bean 생성 */
	@Resource(name = "/sm/srm/sapSlipUploadDAO")
	private SapSlipUploadDAO sapSlipUploadDAO;
	

	/**
	 * SAP 전표 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSlipList(Map<String, Object> mapParam) throws Exception {
		String sSlipTypeBySQL = null;
		
		if(mapParam.get("slipTypeBySQL") != null){
			sSlipTypeBySQL = mapParam.get("slipTypeBySQL").toString();
		}
		
		/***********************************************************
		 * 100% 세금계산서 발행 매출전표 - 세금계산서별
		 * (6B:식재영업,6C:식재도매,6E:연구소,6G:물류매출,6H:기타매출)
		 ***********************************************************/
		if("Tax100".equals(sSlipTypeBySQL)){
			return sapSlipUploadDAO.selectSlipListTax100(mapParam);
			
		/***********************************************************
		 * 급식, 외식 매출전표 - 전표유형별
		 * (6A:FS사업,6D:외식사업,6A:장례식장,6F:특판,6A:매점POS,6D:외식POS)
		 ***********************************************************/
		}else if("TaxEtc".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipListTaxEtc(mapParam);

		/***********************************************************
		 * 7A:입금
		 ***********************************************************/	
		}else if("7A".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7A(mapParam);
			
		/***********************************************************
		 * 7B:채권 이관
		 ***********************************************************/		
		}else if("7B".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7B(mapParam);

		/***********************************************************
		 * 7C:선수금발생 관리
		 ***********************************************************/	
		}else if("7C".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7C(mapParam);

		/***********************************************************
		 * 7D:대손처리
		 ***********************************************************/	
		}else if("7D".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7D(mapParam);
				
		/***********************************************************
		 * 7E:선수금 이관
		 ***********************************************************/
		}else if("7E".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7E(mapParam);	

		/***********************************************************
		 * 7F:영업현금 가수금 대체
		 ***********************************************************/
		}else if("7F".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7F(mapParam);	

		/***********************************************************
		 * 7G:채권채무
		 ***********************************************************/
		}else if("7G".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7G(mapParam);	
				
		/***********************************************************
		 * 7H:기타 가수금 대체
		 ***********************************************************/			
		}else if("7H".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7H(mapParam);
			
		/***********************************************************
		 * 7I:쿠폰(식권)판매/교환/소멸
		 ***********************************************************/	
		}else if("7I".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7I(mapParam);

		/***********************************************************
		 * 7J:상품권 청구
		 ***********************************************************/		
		}else if("7J".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList7J(mapParam);
	
		/***********************************************************
		 * 8A:영업환불(영업미지급)
		 ***********************************************************/	
		}else if("8A".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList8A(mapParam);

		/***********************************************************
		 * 8B:원가 이관(직원식대처리)
		 ***********************************************************/	
		}else if("8B".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList8B(mapParam);
		
		/***********************************************************
		 * 8C:Helper
		 ***********************************************************/				
		}else if("8C".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList8C(mapParam);
			
		/***********************************************************
		 * 8D:영업기타
		 ***********************************************************/		
		}else if("8D".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList8D(mapParam);

		/***********************************************************
		 * 8O:내부이용가계정(내부매출)
		 ***********************************************************/		
		}else if("8O".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList8O(mapParam);
		
		/***********************************************************
	     * 1I:영업기타(H&R) 수입장려금 처리 전표 유형 추가 요청자:유태석 20161223
		 ***********************************************************/		
		}else if("1I".equals(sSlipTypeBySQL)){	
			return sapSlipUploadDAO.selectSlipList1I(mapParam);
							
			
		}else{
			return null;
		}
	}
	
	/**
	 * 전표생성
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public String saveSlipList(DataSetMap list) throws Exception {
		int rowCntMst = 0;
		int rowCntDtl = 0;
		int loopCnt = 0;
		
		int slipCnt = 0;
		int slipMaxCnt = 800;	//테스트 200
		long dSlipAmt = 0;
		long cSlipAmt = 0;
		long iSlipCurrencyAmt = 0;
		long iLcalAmt = 0;
		
		String sSlipNum = "";
		String sSlipNum1 = "";
		String sSlipNum2 = "";
		String sSlipNum3 = "";
		String sSlipNum4 = "";
		String sSlipNum5 = "";
		String sSlipNum6 = "";
		String sSlipNum7 = "";
		String sSlipNum8 = "";
		String sSlipNum9 = "";
		String sSlipNum10 = "";
		String sSlipNum11 = "";
		String sSlipNum12 = "";
		String sSlipNum13 = "";
		String sSlipNum14 = "";
		String sSlipNum15 = "";
		String sSlipNum16 = "";
		String sSlipNum17 = "";
		String sSlipNum18 = "";
		String sSlipNum19 = "";
		String sSlipNum20 = "";
		String sSlipNum21 = "";
		String sSlipNum22 = "";
		String sSlipNum23 = "";
		String sSlipNum24 = "";
		String sSlipNum25 = "";
		String sSlipNum26 = "";
		String sSlipNum27 = "";
		String sSlipNum28 = "";
		String sSlipNum29 = "";
		String sSlipNum30 = "";
		String sSlipNum31 = "";
		String sSlipNum32 = "";
		String sSlipNum33 = "";
		String sSlipNum34 = "";
		String sSlipNum35 = "";
		String sSlipNum36 = "";
		String sSlipNum37 = "";
		String sSlipNum38 = "";
		String sSlipNum39 = "";
		String sSlipNum40 = "";
		String sSlipNum41 = "";
		String sSlipNum42 = "";
		String sSlipNum43 = "";
		String sSlipNum44 = "";
		String sSlipNum45 = "";
		String sSlipNum46 = "";
		String sSlipNum47 = "";
		String sSlipNum48 = "";
		String sSlipNum49 = "";
		String sSlipNum50 = "";
		String sSlipNum51 = "";
		String sSlipNum52 = "";
		String sSlipNum53 = "";
		String sSlipNum54 = "";
		String sSlipNum55 = "";
		String sSlipNum56 = "";
		String sSlipNum57 = "";
		String sSlipNum58 = "";
		String sSlipNum59 = "";
		String sSlipNum60 = "";
		
		
		String beforeSlipNum = "";
		String sSysClass = "";
		String strRtn = "";
		String strRtnMsg = "";
		String sSlipGrpNum = "";
		String sMasterAcct = "";
		String sDrCrClass = "";
		String sMasterAcctTmp = "90006010";	//800라인이 넘을 경우 계정
		String sSlipNumPrev = "";
		String sSlipNumNext = "";
		
		String beforeSlipType = "";
		String nowSlipType = "";
		String beforeTaxShetNum = "";
		String nowTaxShetNum = "";
		String beforeSusAltType = "";
		String nowSusAltType = "";
		String beforeCcCd = "";
		String beforeOrgCcCd = "";
		String nowCcCd = "";
		String nowOrgCcCd = "";
		String orgCcCd = "";
		String beforeReceiptNum = "";
		String nowReceiptNum = "";	
		String beforeGiftBillingNum = "";
		String nowGiftBillingNum = "";	
		String beforeAltNum = "";
		String nowAltNum = "";
		
		Map<String, Object> retVal = null;
		
		int iTotCnt = 0;
		int iMstCnt = 0;
		int iModCnt = 0;		//나머지
		
		//System.out.println("########### 전표생성 Strat ############");
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			if(rowData.get("sysClass") != null)			sSysClass			= rowData.get("sysClass").toString();
			if(rowData.get("slipType") != null) 		nowSlipType			= rowData.get("slipType").toString();
			if(rowData.get("taxShetNum") != null) 		nowTaxShetNum		= rowData.get("taxShetNum").toString();
			if(rowData.get("suspenseAltType") != null) 	nowSusAltType		= rowData.get("suspenseAltType").toString();
			if(rowData.get("ccCd") != null) 			nowCcCd				= rowData.get("ccCd").toString();
			if(rowData.get("ccCdOrg") != null) 			nowOrgCcCd			= rowData.get("ccCdOrg").toString();
			if(rowData.get("ccCdOrg") != null) 			orgCcCd				= rowData.get("ccCdOrg").toString();
			if(rowData.get("receiptNum") != null) 		nowReceiptNum		= rowData.get("receiptNum").toString();
			if(rowData.get("altNum") != null) 			nowAltNum			= rowData.get("altNum").toString();
			if(rowData.get("giftBillingNum") != null) 	nowGiftBillingNum	= rowData.get("giftBillingNum").toString();

			nowCcCd	= orgCcCd;
//			rowData.put("ccCd",	orgCcCd);   <-===================================외상매입대체때문에 수정 김명호:2015-10-16
			
//            System.out.println("["+i+"] ########### beforeReceiptNum:"+beforeReceiptNum);
//            System.out.println("["+i+"] ########### nowReceiptNum:"+nowReceiptNum);
			
			//7B : 채권 이관, 7E : 선수금 이관, 8C : Helper >> 이관전 업장(CC) 사용
//			if("7A".equals(nowSlipType) || "7B".equals(nowSlipType) || "7D".equals(nowSlipType)
//					|| "7E".equals(nowSlipType) || "7J".equals(nowSlipType) || "8C".equals(nowSlipType) || "8O".equals(nowSlipType)){
//				nowCcCd	= orgCcCd;
//				
//			}

    		if(beforeCcCd.equals(nowCcCd)) iTotCnt++;
    		else iTotCnt = 0;
    		
            /***********************************************************
             * 매출전표
             * 6A : 단체급식매출
             * 6B : 식재영업매출
             * 6C : 식재도매매출
             * 6D : 외식사업매출
             * 6E : 연구소매출
             * 6F : 특판매출
             ***********************************************************/
    		/*
            if("6A".equals(nowSlipType)
                    || "6B".equals(nowSlipType)
                    || "6C".equals(nowSlipType)
                    || "6D".equals(nowSlipType)
                    || "6E".equals(nowSlipType)
                    || "6F".equals(nowSlipType)
                    || "6G".equals(nowSlipType)
                    || "6H".equals(nowSlipType)){
            	*/
            if("6A".equals(nowSlipType)
                    || "6B".equals(nowSlipType)
                    || "6C".equals(nowSlipType)
                    || "6D".equals(nowSlipType)
                    || "6E".equals(nowSlipType)
                    || "6G".equals(nowSlipType)
                    || "6H".equals(nowSlipType)){
            	
                if(!"".equals(sSysClass)){

                    /***********************************************************
                     * 100% 세금계산서 발행 매출전표 - 세금계산서별
                     * (6B:식재영업,6C:식재도매,6E:연구소,6G:물류매출,6H:기타매출)
                     ***********************************************************/
                    if("13".equals(sSysClass)
                            || "14".equals(sSysClass)
                            //|| "15".equals(sSysClass)
                            || "23".equals(sSysClass)
                            || "18".equals(sSysClass)
                            || "19".equals(sSysClass)
                            ){

                        //System.out.println("########### beforeTaxShetNum:"+beforeTaxShetNum);
                        //System.out.println("########### nowTaxShetNum:"+nowTaxShetNum);
                        
                        //세금계산서별 전표생성
                        if(!beforeTaxShetNum.equals(nowTaxShetNum)){
                            
                            //전표 마스터 저장
                            sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
                            rowData.put("slipNum",	sSlipNum);
                            rowData.put("sSlipGrpNum",	sSlipNum);
                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
                        }

                    /***********************************************************
                     * 급식, 외식 매출전표 - 전표유형별
                     * (6A:FS사업,6D:외식사업,6A:장례식장,6F:특판,6A:매점POS,6D:외식POS)
                     ***********************************************************/
                    }else{

                        /***********************************************************
                         * 매출전표
                         * - 팀별 업장(CC) 단위로 매출전표가 생성된다.
                         ***********************************************************/
                        if(!beforeCcCd.equals(nowCcCd) || !beforeSlipType.equals(nowSlipType)){

                            //전표 마스터 저장
                            sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
                            rowData.put("slipNum",	sSlipNum);
                            rowData.put("sSlipGrpNum",	sSlipNum);
                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
                        }
                    }
				}
                
				/***********************************************************
				 * 매출전표 외...
				 * 7A : 입금처리
				 * 7B : 채권 이관
				 * 7C : 선수금발생 관리
				 * 7D : 선수금 대체
				 * 7E : 선수금 이관
				 * 7F : 영업현금 가수금 대체
				 * 7G : 식재영업 가수금 대체
				 * 7H : 기타 가수금 대체
				 * 7I : 쿠폰(식권)판매/교환/소멸
				 * 7J : 상품권 청구
				 * 8A : 영업환불(영업미지급)
				 * 8B : 원가 이관(직원식대처리)
				 * 8C : Helper
				 * 8D : 영업기타
				 ***********************************************************/
            }else{
            	
              /***********************************************************
                 * 예외전표 : 8A:환불전표
                 * 환불처리 시 대체번호별 
                 ***********************************************************/	
            	 if("8A".equals(nowSlipType)){
                	
                	//대체번호별 전표생성
                    if(!beforeAltNum.equals(nowAltNum)){
                	
                        /***********************************************************
                         * 영수증번호 단위로 전표가 생성된다.
                         ***********************************************************/
                        //전표 마스터 저장
                        sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
                                                    
                        rowData.put("slipNum",	sSlipNum);
                        rowData.put("sSlipGrpNum",	sSlipNum);
//                        rowData.put("ccCd",	orgCcCd);
                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
                    }
                 //7I전표 선수금용역상품권인 경우 외식사업기획팀CC로 생성되어 전표가 분리되어 잘못발생하는문제 수정 20190306 김호석
                 
            	 } else if("7I".equals(nowSlipType)){
                    	
	                 //사업부별 전표 번호 생성 기준 다르게 적용 20190306 김호석
	            	 if (rowData.get("muCd").equals("2003")) {
	             			//외식사업부인 경우 OrgCcCd로 구분
	            			if(!beforeSlipType.equals(nowSlipType)|| !beforeOrgCcCd.equals(nowOrgCcCd)){
		            		//외식은 전표1개로 생성(팀으로 한번에 생성 불가)
		            		//if(!beforeSlipType.equals(nowSlipType)){
	                            /***********************************************************
	                             * 전표 1개로 전표가 생성된다.
	                             ***********************************************************/                            
	                            //전표 마스터 저장
	                            sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            rowData.put("slipNum",	sSlipNum);
	                            rowData.put("sSlipGrpNum",	sSlipNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
	                        }
	            			
	            	 } else {
	            		//FS사업부인 경우 CC별로 생성 
	              		if(!beforeSlipType.equals(nowSlipType) || !beforeCcCd.equals(nowCcCd)){
	              			 /***********************************************************
	                         * 전표 1개로 전표가 생성된다.
	                         ***********************************************************/                            
	                        //전표 마스터 저장
	                        sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                        rowData.put("slipNum",	sSlipNum);
	                        rowData.put("sSlipGrpNum",	sSlipNum);
	                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
	                    }
	            	 }
				
                /***********************************************************
                 * 예외전표 : 7A:입금관리
                 ***********************************************************/            	
            	 } else if("7A".equals(nowSlipType) || "7C".equals(nowSlipType) || "6F".equals(nowSlipType)){
            		
                    /***********************************************************
                     * 팀별 업장(CC) 단위로 전표가 생성된다.
                     ***********************************************************/   

                    System.out.println("#####################################################");
                    System.out.println("########### rowData:"+rowData);
                    System.out.println("########### iTotCnt:"+iTotCnt);
                    
        				
            		if(!beforeSlipType.equals(nowSlipType) || !beforeCcCd.equals(nowCcCd)){
            			
            			//팀별로 전표 생성 시 조건 초기화 20181210 김호석, 팀별전표 생성 시 전표업데이트가 안되는 문제 수정 
            			sSlipNum2 = "";

                        //전표 마스터 저장
                        sSlipNum1 = sapSlipUploadDAO.getMaxSlipNum(rowData);
//                            System.out.println("#####################################################");
//                            System.out.println("########### sSlipNum:"+sSlipNum);
                        sSlipGrpNum = sSlipNum1;
                        
                        rowData.put("slipNum",	sSlipNum1);
                        rowData.put("sSlipGrpNum",	sSlipGrpNum);
//                            rowData.put("ccCd",	rowData.get("ccCdOrg").toString());
                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            		}
            		//800라인 이상일 경우 전표 마스터 추가 저장
            		//if(iTotCnt == 800 || iTotCnt == 1600 || iTotCnt == 2400 || iTotCnt == 3200 || iTotCnt == 4000){
                	if(iTotCnt == 800 || iTotCnt == 1600 || iTotCnt == 2400 || iTotCnt == 3200 || iTotCnt == 4000 || iTotCnt == 4800 || iTotCnt == 5600
                			|| iTotCnt == 6400 || iTotCnt == 7200 || iTotCnt == 8000 || iTotCnt == 8800 || iTotCnt == 9600 || iTotCnt == 10400
                			|| iTotCnt == 11200 || iTotCnt == 12000 || iTotCnt == 12800 || iTotCnt == 13600 || iTotCnt == 14400 || iTotCnt == 15200
                			|| iTotCnt == 16000 || iTotCnt == 16800 || iTotCnt == 17600 || iTotCnt == 18400 || iTotCnt == 19200 || iTotCnt == 20000
                			|| iTotCnt == 20800 || iTotCnt == 21600 || iTotCnt == 22400 || iTotCnt == 23200 || iTotCnt == 24000 || iTotCnt == 24800
                			|| iTotCnt == 25600 || iTotCnt == 26400 || iTotCnt == 27200 || iTotCnt == 28000 || iTotCnt == 28800 || iTotCnt == 29600
                			|| iTotCnt == 30400 || iTotCnt == 31200 || iTotCnt == 32000 || iTotCnt == 32800 || iTotCnt == 33600 || iTotCnt == 34400
                			|| iTotCnt == 35200 || iTotCnt == 36000 || iTotCnt == 36800 || iTotCnt == 37600 || iTotCnt == 38400 || iTotCnt == 39200
                			|| iTotCnt == 40000 || iTotCnt == 40800 || iTotCnt == 41600 || iTotCnt == 42400 || iTotCnt == 43200 || iTotCnt == 44000
                			){
            			//if(iMstCnt == 0){
//                			System.out.println("########### beforeSlipType:"+beforeSlipType);
//                			System.out.println("########### nowSlipType:"+nowSlipType);
//                			System.out.println("########### beforeCcCd:"+beforeCcCd);
//                			System.out.println("########### nowCcCd:"+nowCcCd);
                            
                            //800라인 이상 전표 마스터 저장
            				if(iTotCnt == 800){
	                            sSlipNum2 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum2);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
	                            
            				}else if(iTotCnt == 1600){
	                            sSlipNum3 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum3);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 2400){
	                            sSlipNum4 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum4);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 3200){
	                            sSlipNum5 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum5);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 4000){
	                            sSlipNum6 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum6);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 4800){
	                            sSlipNum7 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum7);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 5600){
	                            sSlipNum8 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum8);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 6400){
	                            sSlipNum9 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum9);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 7200){
	                            sSlipNum10 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum10);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 8000){
	                            sSlipNum11 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum11);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 8800){
	                            sSlipNum12 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum12);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 9600){
	                            sSlipNum13 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum13);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 10400){
	                            sSlipNum14 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum14);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            

            				}else if(iTotCnt == 11200){
	                            sSlipNum15 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum15);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 12000){
	                            sSlipNum16 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum16);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 12800){
	                            sSlipNum17 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum17);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 13600){
	                            sSlipNum18 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum18);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 14400){
	                            sSlipNum19 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum19);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 15200){
	                            sSlipNum20 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum20);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 16000){
	                            sSlipNum21 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            //System.out.println("########### sSlipNum21:"+sSlipNum21);
	                            
	                            rowData.put("slipNum",		sSlipNum21);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 16800){
	                            sSlipNum22 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum22);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 17600){
	                            sSlipNum23 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum23);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 18400){
	                            sSlipNum24 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum24);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 19200){
	                            sSlipNum25 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum25);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 20000){
	                            sSlipNum26 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum26);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 20800){
	                            sSlipNum27 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum27);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 21600){
	                            sSlipNum28 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum28);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 22400){
	                            sSlipNum29 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum29);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 23200){
	                            sSlipNum30 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum30);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 24000){
	                            sSlipNum31 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            //System.out.println("########### sSlipNum31:"+sSlipNum31);
	                            
	                            rowData.put("slipNum",		sSlipNum31);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 24800){
	                            sSlipNum32 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum32);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
	                            
	                            
	                            
            				}else if(iTotCnt == 25600){
	                            sSlipNum33 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum33);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 26400){
	                            sSlipNum34 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum34);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 27200){
	                            sSlipNum35 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum35);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 28000){
	                            sSlipNum36 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum36);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 28800){
	                            sSlipNum37 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum37);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 29600){
	                            sSlipNum38 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum38);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 30400){
	                            sSlipNum39 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum39);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 31200){
	                            sSlipNum40 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum40);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 32000){
	                            sSlipNum41 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            //System.out.println("########### sSlipNum41:"+sSlipNum41);
	                            
	                            rowData.put("slipNum",		sSlipNum41);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 32800){
	                            sSlipNum42 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum42);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 33600){
	                            sSlipNum43 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum43);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 34400){
	                            sSlipNum44 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum44);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 35200){
	                            sSlipNum45 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum45);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 36000){
	                            sSlipNum46 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum46);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 36800){
	                            sSlipNum47 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum47);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 37600){
	                            sSlipNum48 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum48);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 38400){
	                            sSlipNum49 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum49);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 39200){
	                            sSlipNum50 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum50);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 40000){
	                            sSlipNum51 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            //System.out.println("########### sSlipNum51:"+sSlipNum51);
	                            
	                            rowData.put("slipNum",		sSlipNum51);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 40800){
	                            sSlipNum52 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum52);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 41600){
	                            sSlipNum53 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum53);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 42400){
	                            sSlipNum54 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum54);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 43200){
	                            sSlipNum55 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum55);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 44000){
	                            sSlipNum56 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum56);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}
            				
            			//	iMstCnt++;
            			//}
            		}
            		sSlipGrpNum = "";
            		
                /***********************************************************
                 * 예외전표 : 7H:기타 가수금 대체, 8D:영업기타
                 * 가수금 타입별 전표생성
                 ***********************************************************/
            		
            	//}else if("7H".equals(nowSlipType)){	// || "8D".equals(nowSlipType)){
                	
                    /***********************************************************
                     * 가수금 타입별, 팀별 업장(CC) 단위로 전표가 생성된다.
                     ***********************************************************/                	
  /*
            		if(!beforeSusAltType.equals(nowSusAltType) || !beforeCcCd.equals(nowCcCd)){
                		
                        //전표 마스터 저장
                        sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
                        rowData.put("slipNum",	sSlipNum);
                        rowData.put("sSlipGrpNum",	sSlipNum);
                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
                	}
*/
                /***********************************************************
                 * 예외전표 : 7J:상품권 청구
                 * 상품권청구번호별 전표생성
                 ***********************************************************/	
                }else if("7J".equals(nowSlipType)){
                	
//                	System.out.println("#############################################");
//                	System.out.println("##### beforeGiftBillingNum:"+beforeGiftBillingNum);
//                	System.out.println("##### nowGiftBillingNum:"+nowGiftBillingNum);
                	
                	if(!beforeGiftBillingNum.equals(nowGiftBillingNum)){
                        /***********************************************************
                         * 상품권청구번호별로 전표가 생성된다.
                         ***********************************************************/	
                        //전표 마스터 저장
                        sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
                        rowData.put("slipNum",	sSlipNum);
                        rowData.put("sSlipGrpNum",	sSlipNum);
//                        rowData.put("ccCd",	rowData.get("ccCdOrg").toString());
                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
                    }
                
                //7B : 채권 이관, 7E : 선수금 이관, 8C : Helper >> 이관전 업장(CC) 사용
                }else if("7B".equals(nowSlipType) || "7D".equals(nowSlipType) || "7E".equals(nowSlipType) || "8C".equals(nowSlipType) || "7G".equals(nowSlipType) || "7H".equals(nowSlipType)){
                
                    /***********************************************************
                     * 팀별 이관전 업장(CC) 단위로 전표가 생성된다.
                     ***********************************************************/	
                	if("7B".equals(nowSlipType) || "7D".equals(nowSlipType) || "7E".equals(nowSlipType) || "8C".equals(nowSlipType) || "7G".equals(nowSlipType)){
	                	if(!beforeSlipType.equals(nowSlipType) || !beforeCcCd.equals(nowCcCd)){
	                		
	            			//팀별로 전표 생성 시 조건 초기화 20181210 김호석, 팀별전표 생성 시 전표업데이트가 안되는 문제 수정 
	            			sSlipNum2 = "";
	            			
	                        //전표 마스터 저장
	                        //sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                        //rowData.put("slipNum",	sSlipNum);
	                        //rowData.put("sSlipGrpNum",	sSlipNum);
	//                        rowData.put("ccCd",	rowData.get("ccCdOrg").toString());
	                        //rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
	                        
	                        //전표 마스터 저장
	                        sSlipNum1 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	//                            System.out.println("#####################################################");
	//                            System.out.println("########### sSlipNum:"+sSlipNum);
	                        sSlipGrpNum = sSlipNum1;
	                        
	                        rowData.put("slipNum",	sSlipNum1);
	                        rowData.put("sSlipGrpNum",	sSlipGrpNum);
	//                            rowData.put("ccCd",	rowData.get("ccCdOrg").toString());
	                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
	                        
	                	}
                	}
                	/***********************************************************
                     * 가수금 타입별, 팀별 업장(CC) 단위로 전표가 생성된다.
                     ***********************************************************/                	
                	if("7H".equals(nowSlipType)){
                		
                		//대체 or 입금번호별 전표생성 20180830 김호석 수정(대체 건별로 취소/생성 가능하도록 수정) : 기존에는 전체 취소만 가능
                        if(!beforeAltNum.equals(nowAltNum)){
                        	
                			//팀별로 전표 생성 시 조건 초기화 20181210 김호석, 팀별전표 생성 시 전표업데이트가 안되는 문제 수정 
                			sSlipNum2 = "";
                			iTotCnt = 0; //대체번호가 다르면 초기화 필요 20190805 김호석
                            /***********************************************************
                             * 대체번호 단위로 전표가 생성된다.
                             ***********************************************************/
                        	//전표 마스터 저장
	                        //sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
                  		    sSlipNum1 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                        sSlipGrpNum = sSlipNum1;
	                        rowData.put("slipNum",	sSlipNum1);
	                        rowData.put("sSlipGrpNum",	sSlipNum);
	                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
                        }
                         /*
	                	if(!beforeSusAltType.equals(nowSusAltType) || !beforeCcCd.equals(nowCcCd)){
	                		
	                        //전표 마스터 저장
	                        //sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
                  		    sSlipNum1 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                        sSlipGrpNum = sSlipNum1;
	                        rowData.put("slipNum",	sSlipNum1);
	                        rowData.put("sSlipGrpNum",	sSlipNum);
	                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
	                	}
	                	*/
                	}

                	//800라인 이상일 경우 전표 마스터 추가 저장
            		//if(iTotCnt == 800 || iTotCnt == 1600 || iTotCnt == 2400 || iTotCnt == 3200 || iTotCnt == 4000){
                	if(iTotCnt == 800 || iTotCnt == 1600 || iTotCnt == 2400 || iTotCnt == 3200 || iTotCnt == 4000 || iTotCnt == 4800 || iTotCnt == 5600
                			|| iTotCnt == 6400 || iTotCnt == 7200 || iTotCnt == 8000 || iTotCnt == 8800 || iTotCnt == 9600 || iTotCnt == 10400 
                			|| iTotCnt == 11200 || iTotCnt == 12000 || iTotCnt == 12800 || iTotCnt == 13600 || iTotCnt == 14400 || iTotCnt == 15200
                			|| iTotCnt == 16000 || iTotCnt == 16800 || iTotCnt == 17600 || iTotCnt == 18400 || iTotCnt == 19200 || iTotCnt == 20000
                			|| iTotCnt == 20800 || iTotCnt == 21600 || iTotCnt == 22400 || iTotCnt == 23200 || iTotCnt == 24000 || iTotCnt == 24800
                			|| iTotCnt == 25600 || iTotCnt == 26400 || iTotCnt == 27200 || iTotCnt == 28000 || iTotCnt == 28800 || iTotCnt == 29600
                			|| iTotCnt == 30400 || iTotCnt == 31200 || iTotCnt == 32000 || iTotCnt == 32800 || iTotCnt == 33600 || iTotCnt == 34400
                			|| iTotCnt == 35200 || iTotCnt == 36000 || iTotCnt == 36800 || iTotCnt == 37600 || iTotCnt == 38400 || iTotCnt == 39200
                			|| iTotCnt == 40000 || iTotCnt == 40800 || iTotCnt == 41600 || iTotCnt == 42400 || iTotCnt == 43200 || iTotCnt == 44000
                			
                			){
            			if(iMstCnt == 0){
	              			System.out.println("########### beforeSlipType:"+beforeSlipType);
	               			System.out.println("########### nowSlipType:"+nowSlipType);
	               			System.out.println("########### beforeCcCd:"+beforeCcCd);
	               			System.out.println("########### nowCcCd:"+nowCcCd);
            			}
                            
                            //800라인 이상 전표 마스터 저장
            				if(iTotCnt == 800){
	                            sSlipNum2 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            //System.out.println("########### sSlipNum2:"+sSlipNum2);
	                            
	                            rowData.put("slipNum",		sSlipNum2);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 1600){
	                            sSlipNum3 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum3);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 2400){
	                            sSlipNum4 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum4);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 3200){
	                            sSlipNum5 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum5);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 4000){
	                            sSlipNum6 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum6);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 4800){
	                            sSlipNum7 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum7);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 5600){
	                            sSlipNum8 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum8);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 6400){
	                            sSlipNum9 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum9);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 7200){
	                            sSlipNum10 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum10);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 8000){
	                            sSlipNum11 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            System.out.println("########### sSlipNum11:"+sSlipNum11);
	                            
	                            rowData.put("slipNum",		sSlipNum11);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 8800){
	                            sSlipNum12 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum12);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 9600){
	                            sSlipNum13 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum13);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
            				}else if(iTotCnt == 10400){
	                            sSlipNum14 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum14);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);	            					
	                            
            				}else if(iTotCnt == 11200){
	                            sSlipNum15 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum15);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 12000){
	                            sSlipNum16 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum16);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 12800){
	                            sSlipNum17 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum17);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 13600){
	                            sSlipNum18 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum18);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 14400){
	                            sSlipNum19 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum19);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 15200){
	                            sSlipNum20 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum20);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 16000){
	                            sSlipNum21 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            System.out.println("########### sSlipNum21:"+sSlipNum21);
	                            
	                            rowData.put("slipNum",		sSlipNum21);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 16800){
	                            sSlipNum22 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum22);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 17600){
	                            sSlipNum23 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum23);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 18400){
	                            sSlipNum24 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum24);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 19200){
	                            sSlipNum25 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum25);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 20000){
	                            sSlipNum26 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum26);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 20800){
	                            sSlipNum27 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum27);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 21600){
	                            sSlipNum28 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum28);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 22400){
	                            sSlipNum29 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum29);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 23200){
	                            sSlipNum30 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum30);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 24000){
	                            sSlipNum31 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            System.out.println("########### sSlipNum31:"+sSlipNum31);
	                            
	                            rowData.put("slipNum",		sSlipNum31);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 24800){
	                            sSlipNum32 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum32);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
	                            
	                            
	                            
            				}else if(iTotCnt == 25600){
	                            sSlipNum33 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum33);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 26400){
	                            sSlipNum34 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum34);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 27200){
	                            sSlipNum35 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum35);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 28000){
	                            sSlipNum36 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum36);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 28800){
	                            sSlipNum37 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum37);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 29600){
	                            sSlipNum38 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum38);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 30400){
	                            sSlipNum39 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum39);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 31200){
	                            sSlipNum40 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum40);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 32000){
	                            sSlipNum41 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            System.out.println("########### sSlipNum41:"+sSlipNum41);
	                            
	                            rowData.put("slipNum",		sSlipNum41);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 32800){
	                            sSlipNum42 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum42);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 33600){
	                            sSlipNum43 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum43);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 34400){
	                            sSlipNum44 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum44);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 35200){
	                            sSlipNum45 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum45);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 36000){
	                            sSlipNum46 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum46);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 36800){
	                            sSlipNum47 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum47);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 37600){
	                            sSlipNum48 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum48);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 38400){
	                            sSlipNum49 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum49);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 39200){
	                            sSlipNum50 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum50);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 40000){
	                            sSlipNum51 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            System.out.println("########### sSlipNum51:"+sSlipNum51);
	                            
	                            rowData.put("slipNum",		sSlipNum51);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 40800){
	                            sSlipNum52 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum52);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 41600){
	                            sSlipNum53 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum53);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 42400){
	                            sSlipNum54 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum54);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 43200){
	                            sSlipNum55 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum55);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
            				}else if(iTotCnt == 44000){
	                            sSlipNum56 = sapSlipUploadDAO.getMaxSlipNum(rowData);
	                            
	                            rowData.put("slipNum",		sSlipNum56);
	                            rowData.put("sSlipGrpNum",	sSlipGrpNum);
	                            rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
                           
	                            
            				}
            				
            			//	iMstCnt++;
            			//}
            		}

                /***********************************************************
                 * 예외전표 : 8O:내부이용가계정(내부매출)
                 * 영수증번호별 전표생성
                 ***********************************************************/	
                }else if("8O".equals(nowSlipType)){
                	
                	if(!beforeReceiptNum.equals(nowReceiptNum)){

                        /***********************************************************
                         * 영수증번호 단위로 전표가 생성된다.
                         ***********************************************************/
                        //전표 마스터 저장
                        sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
                        
                        rowData.put("slipNum",	sSlipNum);
                        rowData.put("sSlipGrpNum",	sSlipNum);
//                        rowData.put("ccCd",	orgCcCd);
                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
                	}
                		
                /***********************************************************
                 * 일반 : 전표유형별 전표생성
                 ***********************************************************/
                }else{
//                	  System.out.println("########### [:"+i+"] #################################");
//                    System.out.println("########### beforeSlipType:"+beforeSlipType);
//                    System.out.println("########### nowSlipType:"+nowSlipType);
//                    System.out.println("########### beforeCcCd:"+beforeCcCd);
//                    System.out.println("########### nowCcCd:"+nowCcCd);
                    /***********************************************************
                     * 팀별 업장(CC) 단위로 전표가 생성된다.
                     ***********************************************************/
                	if(!beforeSlipType.equals(nowSlipType) || !beforeCcCd.equals(nowCcCd)){

                        //전표 마스터 저장
                        sSlipNum = sapSlipUploadDAO.getMaxSlipNum(rowData);
//                        System.out.println("#####################################################");
//                        System.out.println("########### sSlipNum:"+sSlipNum);
                        
                        rowData.put("slipNum",	sSlipNum);
                        rowData.put("sSlipGrpNum",	sSlipNum);
                        rowCntMst += sapSlipUploadDAO.insertSapSlipMst(rowData);
                                              
                	}
                } 
			}
			
			/***********************************************************
			 * 전표 디테일 저장 - 라인별 1:1 데이터 저장
			 ***********************************************************/
            //7A:입금전표   
            //System.out.println("1#####################################################");            
            //System.out.println("########### iTotCnt:"+iTotCnt);
            //System.out.println("########### sSlipNum:"+sSlipNum);    
            //System.out.println("########### sSlipNum1:"+sSlipNum1);  
            //System.out.println("########### sSlipNum2:"+sSlipNum2);      
            //System.out.println("1#####################################################");
            if("7A".equals(nowSlipType) || "7B".equals(nowSlipType) || "7C".equals(nowSlipType) || "7D".equals(nowSlipType) || "7E".equals(nowSlipType) || "6F".equals(nowSlipType) || "7B".equals(nowSlipType) || "7G".equals(nowSlipType) || "8C".equals(nowSlipType) || "7H".equals(nowSlipType) ){
            	            	
        		//800라인 이상일 경우
            	if(iTotCnt >800 && iTotCnt <= 1600){
    				sSlipNum = sSlipNum2;
				}else if(iTotCnt >1600 && iTotCnt <= 2400){
    				sSlipNum = sSlipNum3;        					
				}else if(iTotCnt >2400 && iTotCnt <= 3200){
    				sSlipNum = sSlipNum4;        					
				}else if(iTotCnt >3200 && iTotCnt <= 4000){
    				sSlipNum = sSlipNum5;     
				}else if(iTotCnt >4000 && iTotCnt <= 4800){
    				sSlipNum = sSlipNum6;  
				}else if(iTotCnt >4800 && iTotCnt <= 5600){
    				sSlipNum = sSlipNum7;  
				}else if(iTotCnt >5600 && iTotCnt <= 6400){
    				sSlipNum = sSlipNum8;  
				}else if(iTotCnt >6400 && iTotCnt <= 7200){
    				sSlipNum = sSlipNum9;  
				}else if(iTotCnt >7200 && iTotCnt <= 8000){
    				sSlipNum = sSlipNum10;  
				}else if(iTotCnt >8000 && iTotCnt <= 8800){
    				sSlipNum = sSlipNum11;  
				}else if(iTotCnt >8800 && iTotCnt <= 9600){
    				sSlipNum = sSlipNum12;  
				}else if(iTotCnt >9600 && iTotCnt <= 10400){
    				sSlipNum = sSlipNum13;  

				}else if(iTotCnt >10400 && iTotCnt <= 11200){
    				sSlipNum = sSlipNum14;  
				}else if(iTotCnt >11200 && iTotCnt <= 12000){
    				sSlipNum = sSlipNum15;
				}else if(iTotCnt >12000 && iTotCnt <= 12800){
    				sSlipNum = sSlipNum16;  
				}else if(iTotCnt >12800 && iTotCnt <= 13600){
    				sSlipNum = sSlipNum17;  
				}else if(iTotCnt >13600 && iTotCnt <= 14400){
    				sSlipNum = sSlipNum18;  
				}else if(iTotCnt >14400 && iTotCnt <= 15200){
    				sSlipNum = sSlipNum19;  
				}else if(iTotCnt >15200 && iTotCnt <= 16000){
    				sSlipNum = sSlipNum20;  
				}else if(iTotCnt >16000 && iTotCnt <= 16800){
    				sSlipNum = sSlipNum21;  
				}else if(iTotCnt >16800 && iTotCnt <= 17600){
    				sSlipNum = sSlipNum22;  
				}else if(iTotCnt >17600 && iTotCnt <= 18400){
    				sSlipNum = sSlipNum23;  
				}else if(iTotCnt >18400 && iTotCnt <= 19200){
    				sSlipNum = sSlipNum24;  
				}else if(iTotCnt >19200 && iTotCnt <= 20000){
    				sSlipNum = sSlipNum25;  
				}else if(iTotCnt >20000 && iTotCnt <= 20800){
    				sSlipNum = sSlipNum26;  
				}else if(iTotCnt >20800 && iTotCnt <= 21600){
    				sSlipNum = sSlipNum27;  
				}else if(iTotCnt >21600 && iTotCnt <= 22400){
    				sSlipNum = sSlipNum28;
				}else if(iTotCnt >22400 && iTotCnt <= 23200){
    				sSlipNum = sSlipNum29;  
				}else if(iTotCnt >23200 && iTotCnt <= 24000){
    				sSlipNum = sSlipNum30;  
				}else if(iTotCnt >24000 && iTotCnt <= 24800){
    				sSlipNum = sSlipNum31;
    				
				}else if(iTotCnt >24800 && iTotCnt <= 25600){
    				sSlipNum = sSlipNum32;  
				}else if(iTotCnt >25600 && iTotCnt <= 26400){
    				sSlipNum = sSlipNum33;  
				}else if(iTotCnt >26400 && iTotCnt <= 27200){
    				sSlipNum = sSlipNum34;  
				}else if(iTotCnt >27200 && iTotCnt <= 28000){
    				sSlipNum = sSlipNum35;  
				}else if(iTotCnt >28000 && iTotCnt <= 28800){
    				sSlipNum = sSlipNum36;  
				}else if(iTotCnt >28800 && iTotCnt <= 29600){
    				sSlipNum = sSlipNum37;  
				}else if(iTotCnt >29600 && iTotCnt <= 30400){
    				sSlipNum = sSlipNum38;  
				}else if(iTotCnt >30400 && iTotCnt <= 31200){
    				sSlipNum = sSlipNum39;  
				}else if(iTotCnt >31200 && iTotCnt <= 32000){
    				sSlipNum = sSlipNum40;  
				}else if(iTotCnt >32000 && iTotCnt <= 32800){
    				sSlipNum = sSlipNum41;  
				}else if(iTotCnt >32800 && iTotCnt <= 33600){
    				sSlipNum = sSlipNum42;  
				}else if(iTotCnt >33600 && iTotCnt <= 34400){
    				sSlipNum = sSlipNum43;  
				}else if(iTotCnt >34400 && iTotCnt <= 35200){
    				sSlipNum = sSlipNum44;  
				}else if(iTotCnt >35200 && iTotCnt <= 36000){
    				sSlipNum = sSlipNum45;  
				}else if(iTotCnt >36000 && iTotCnt <= 36800){
    				sSlipNum = sSlipNum46;  
				}else if(iTotCnt >36800 && iTotCnt <= 37600){
    				sSlipNum = sSlipNum47;  
				}else if(iTotCnt >37600 && iTotCnt <= 38400){
    				sSlipNum = sSlipNum48;  
				}else if(iTotCnt >38400 && iTotCnt <= 39200){
    				sSlipNum = sSlipNum49;  
				}else if(iTotCnt >39200 && iTotCnt <= 40000){
    				sSlipNum = sSlipNum50;  
				}else if(iTotCnt >40000 && iTotCnt <= 40800){
    				sSlipNum = sSlipNum51;  
				}else if(iTotCnt >40800 && iTotCnt <= 41600){
    				sSlipNum = sSlipNum52;  
				}else if(iTotCnt >41600 && iTotCnt <= 42400){
    				sSlipNum = sSlipNum53;  
				}else if(iTotCnt >42400 && iTotCnt <= 43200){
    				sSlipNum = sSlipNum54;  
				}else if(iTotCnt >43200 && iTotCnt <= 44000){
    				sSlipNum = sSlipNum55;
				}else if(iTotCnt >44000){
    				sSlipNum = sSlipNum56;        					
        		}else{
        			sSlipNum = sSlipNum1;
        		}
            	
				sDrCrClass = rowData.get("drCrClass").toString();
				
				//차변금액의 합계
				if("1".equals(sDrCrClass)){
					dSlipAmt += Long.parseLong(rowData.get("lcalAmt").toString());
					
				//대변금액의 합계
				}else{
					cSlipAmt += Long.parseLong(rowData.get("lcalAmt").toString());
				}
				
                System.out.println("###########================================================================== sSlipNum:"+sSlipNum);
    			rowData.put("slipNum",	sSlipNum);
    			rowCntDtl += sapSlipUploadDAO.insertSapSlipDtl(rowData);
    			
    			if(iTotCnt == 800 || iTotCnt == 1600 || iTotCnt == 2400 || iTotCnt == 3200 || iTotCnt == 4000 || iTotCnt == 4800 || iTotCnt == 5600
            			|| iTotCnt == 6400 || iTotCnt == 7200 || iTotCnt == 8000 || iTotCnt == 8800 || iTotCnt == 9600 || iTotCnt == 10400
            			|| iTotCnt == 11200 || iTotCnt == 12000 || iTotCnt == 12800 || iTotCnt == 13600 || iTotCnt == 14400 || iTotCnt == 15200
            			|| iTotCnt == 16000 || iTotCnt == 16800 || iTotCnt == 17600 || iTotCnt == 18400 || iTotCnt == 19200 || iTotCnt == 20000
            			|| iTotCnt == 20800 || iTotCnt == 21600 || iTotCnt == 22400 || iTotCnt == 23200 || iTotCnt == 24000 || iTotCnt == 24800
            			|| iTotCnt == 25600 || iTotCnt == 26400 || iTotCnt == 27200 || iTotCnt == 28000 || iTotCnt == 28800 || iTotCnt == 29600
            			|| iTotCnt == 30400 || iTotCnt == 31200 || iTotCnt == 32000 || iTotCnt == 32800 || iTotCnt == 33600 || iTotCnt == 34400
            			|| iTotCnt == 35200 || iTotCnt == 36000 || iTotCnt == 36800 || iTotCnt == 37600 || iTotCnt == 38400 || iTotCnt == 39200
            			|| iTotCnt == 40000 || iTotCnt == 40800 || iTotCnt == 41600 || iTotCnt == 42400 || iTotCnt == 43200 || iTotCnt == 44000
            			){
                	if(iTotCnt ==800){
        				sSlipNumPrev = sSlipNum1;
        				sSlipNumNext = sSlipNum2;        				
    				}else if(iTotCnt ==1600){
        				sSlipNumPrev = sSlipNum2;
        				sSlipNumNext = sSlipNum3;        				
    				}else if(iTotCnt ==2400){
        				sSlipNumPrev = sSlipNum3;
        				sSlipNumNext = sSlipNum4;        				
    				}else if(iTotCnt ==3200){
        				sSlipNumPrev = sSlipNum4;
        				sSlipNumNext = sSlipNum5;        				
    				}else if(iTotCnt ==4000){
        				sSlipNumPrev = sSlipNum5;
        				sSlipNumNext = sSlipNum6;  
    				}else if(iTotCnt ==4800){
        				sSlipNumPrev = sSlipNum6;
        				sSlipNumNext = sSlipNum7;     
    				}else if(iTotCnt ==5600){
        				sSlipNumPrev = sSlipNum7;
        				sSlipNumNext = sSlipNum8;     
    				}else if(iTotCnt ==6400){
        				sSlipNumPrev = sSlipNum8;
        				sSlipNumNext = sSlipNum9;     
    				}else if(iTotCnt ==7200){
        				sSlipNumPrev = sSlipNum9;
        				sSlipNumNext = sSlipNum10;     
    				}else if(iTotCnt ==8000){
        				sSlipNumPrev = sSlipNum10;
        				sSlipNumNext = sSlipNum11;     
    				}else if(iTotCnt ==8800){
        				sSlipNumPrev = sSlipNum11;
        				sSlipNumNext = sSlipNum12;     
    				}else if(iTotCnt ==9600){
        				sSlipNumPrev = sSlipNum12;
        				sSlipNumNext = sSlipNum13;     
    				}else if(iTotCnt ==10400){
        				sSlipNumPrev = sSlipNum13;
        				sSlipNumNext = sSlipNum14;         				
        			     
    				}else if(iTotCnt ==11200){
        				sSlipNumPrev = sSlipNum14;
        				sSlipNumNext = sSlipNum15;      
    				}else if(iTotCnt ==12000){
        				sSlipNumPrev = sSlipNum15;
        				sSlipNumNext = sSlipNum16;      
    				}else if(iTotCnt ==12800){
        				sSlipNumPrev = sSlipNum16;
        				sSlipNumNext = sSlipNum17;      
    				}else if(iTotCnt ==13600){
        				sSlipNumPrev = sSlipNum17;
        				sSlipNumNext = sSlipNum18;      
    				}else if(iTotCnt ==14400){
        				sSlipNumPrev = sSlipNum18;
        				sSlipNumNext = sSlipNum19;      
    				}else if(iTotCnt ==15200){
        				sSlipNumPrev = sSlipNum19;
        				sSlipNumNext = sSlipNum20;      
    				}else if(iTotCnt ==16000){
        				sSlipNumPrev = sSlipNum20;
        				sSlipNumNext = sSlipNum21;      
    				}else if(iTotCnt ==16800){
        				sSlipNumPrev = sSlipNum21;
        				sSlipNumNext = sSlipNum22;      
    				}else if(iTotCnt ==17600){
        				sSlipNumPrev = sSlipNum22;
        				sSlipNumNext = sSlipNum23;      
    				}else if(iTotCnt ==18400){
        				sSlipNumPrev = sSlipNum23;
        				sSlipNumNext = sSlipNum24;      
    				}else if(iTotCnt ==19200){
        				sSlipNumPrev = sSlipNum24;
        				sSlipNumNext = sSlipNum25;      
    				}else if(iTotCnt ==20000){
        				sSlipNumPrev = sSlipNum25;
        				sSlipNumNext = sSlipNum26;       
    				}else if(iTotCnt ==20800){
        				sSlipNumPrev = sSlipNum26;
        				sSlipNumNext = sSlipNum27;       
    				}else if(iTotCnt ==21600){
        				sSlipNumPrev = sSlipNum27;
        				sSlipNumNext = sSlipNum28;       
    				}else if(iTotCnt ==22400){
        				sSlipNumPrev = sSlipNum28;
        				sSlipNumNext = sSlipNum29;       
    				}else if(iTotCnt ==23200){
        				sSlipNumPrev = sSlipNum29;
        				sSlipNumNext = sSlipNum30;       
    				}else if(iTotCnt ==24000){
        				sSlipNumPrev = sSlipNum30;
        				sSlipNumNext = sSlipNum31;       
    				}else if(iTotCnt ==24800){
        				sSlipNumPrev = sSlipNum31;
        				sSlipNumNext = sSlipNum32;  
        				
    				}else if(iTotCnt ==25600){
        				sSlipNumPrev = sSlipNum32;
        				sSlipNumNext = sSlipNum33;       
    				}else if(iTotCnt ==26400){
        				sSlipNumPrev = sSlipNum33;
        				sSlipNumNext = sSlipNum34;        
    				}else if(iTotCnt ==27200){
        				sSlipNumPrev = sSlipNum34;
        				sSlipNumNext = sSlipNum35;        
    				}else if(iTotCnt ==28000){
        				sSlipNumPrev = sSlipNum35;
        				sSlipNumNext = sSlipNum36;        
    				}else if(iTotCnt ==28800){
        				sSlipNumPrev = sSlipNum36;
        				sSlipNumNext = sSlipNum37;        
    				}else if(iTotCnt ==29600){
        				sSlipNumPrev = sSlipNum37;
        				sSlipNumNext = sSlipNum38;        
    				}else if(iTotCnt ==30400){
        				sSlipNumPrev = sSlipNum38;
        				sSlipNumNext = sSlipNum39;        
    				}else if(iTotCnt ==31200){
        				sSlipNumPrev = sSlipNum39;
        				sSlipNumNext = sSlipNum40;        
    				}else if(iTotCnt ==32000){
        				sSlipNumPrev = sSlipNum40;
        				sSlipNumNext = sSlipNum41;        
    				}else if(iTotCnt ==32800){
        				sSlipNumPrev = sSlipNum41;
        				sSlipNumNext = sSlipNum42;        
    				}else if(iTotCnt ==33600){
        				sSlipNumPrev = sSlipNum42;
        				sSlipNumNext = sSlipNum43;        
    				}else if(iTotCnt ==34400){
        				sSlipNumPrev = sSlipNum43;
        				sSlipNumNext = sSlipNum44;        
    				}else if(iTotCnt ==35200){
        				sSlipNumPrev = sSlipNum44;
        				sSlipNumNext = sSlipNum45;        
    				}else if(iTotCnt ==36000){
        				sSlipNumPrev = sSlipNum45;
        				sSlipNumNext = sSlipNum46;        
    				}else if(iTotCnt ==36800){
        				sSlipNumPrev = sSlipNum46;
        				sSlipNumNext = sSlipNum47;        
    				}else if(iTotCnt ==37600){
        				sSlipNumPrev = sSlipNum47;
        				sSlipNumNext = sSlipNum48;        
    				}else if(iTotCnt ==38400){
        				sSlipNumPrev = sSlipNum48;
        				sSlipNumNext = sSlipNum49;        
    				}else if(iTotCnt ==39200){
        				sSlipNumPrev = sSlipNum49;
        				sSlipNumNext = sSlipNum50;        
    				}else if(iTotCnt ==40000){
        				sSlipNumPrev = sSlipNum50;
        				sSlipNumNext = sSlipNum51;        
    				}else if(iTotCnt ==40800){
        				sSlipNumPrev = sSlipNum51;
        				sSlipNumNext = sSlipNum52;        
    				}else if(iTotCnt ==41600){
        				sSlipNumPrev = sSlipNum52;
        				sSlipNumNext = sSlipNum53;        
    				}else if(iTotCnt ==42400){
        				sSlipNumPrev = sSlipNum53;
        				sSlipNumNext = sSlipNum54;        
    				}else if(iTotCnt ==43200){
        				sSlipNumPrev = sSlipNum54;
        				sSlipNumNext = sSlipNum55;        
    				}else if(iTotCnt ==44000){
        				sSlipNumPrev = sSlipNum55;
        				sSlipNumNext = sSlipNum56;     
            		}    				

    				
    				sMasterAcct = rowData.get("masterAcct").toString();
    				sDrCrClass = rowData.get("drCrClass").toString();
    				iSlipCurrencyAmt =  Long.parseLong(rowData.get("slipCurrencyAmt").toString());
    				iLcalAmt =  Long.parseLong(rowData.get("lcalAmt").toString());
    				
    				//대변:90006010 차이금액(+)
    				rowData.put("slipNum",	sSlipNumPrev);
    				rowData.put("masterAcct", sMasterAcctTmp);
    				rowData.put("drCrClass", "2");
    				rowData.put("slipCurrencyAmt", dSlipAmt - cSlipAmt);
    				rowData.put("lcalAmt", dSlipAmt - cSlipAmt);
    				rowData.put("supplyplceNum", "");
    				rowData.put("guestNum", "");
    				rowData.put("foSupplyplceNum", "");
    				rowData.put("foCustNm", "");
    				rowData.put("expireCalBasisDate", "");
    				rowData.put("payCond", "");
    				rowData.put("assignNum", "");
    				rowData.put("mgmtArticle", "");
    				rowData.put("reasonCd", "");
    				rowData.put("coPaGuest", "");
    				rowData.put("mgmtGuest", "");
    				
    				rowCntDtl += sapSlipUploadDAO.insertSapSlipDtl(rowData);
    				
    				//차변:90006010 차이금액(+)
    				rowData.put("slipNum",	sSlipNumNext);
    				rowData.put("masterAcct", sMasterAcctTmp);
    				rowData.put("drCrClass", "1");
    				rowData.put("slipCurrencyAmt", dSlipAmt - cSlipAmt);
    				rowData.put("lcalAmt", dSlipAmt - cSlipAmt);
    				rowData.put("supplyplceNum", "");
    				rowData.put("guestNum", "");
    				rowData.put("foSupplyplceNum", "");
    				rowData.put("foCustNm", "");
    				rowData.put("expireCalBasisDate", "");
    				rowData.put("payCond", "");
    				rowData.put("assignNum", "");
    				rowData.put("mgmtArticle", "");
    				rowData.put("reasonCd", "");
    				rowData.put("coPaGuest", "");
    				rowData.put("mgmtGuest", "");

    				rowCntDtl += sapSlipUploadDAO.insertSapSlipDtl(rowData);
    				
    				//rowData 초기화
//    				rowData.put("masterAcct", sMasterAcct);
//    				rowData.put("drCrClass", sDrCrClass);
//    				rowData.put("slipCurrencyAmt", iSlipCurrencyAmt);
//    				rowData.put("lcalAmt", iLcalAmt);
    			//	dSlipAmt = 0;
    			//	cSlipAmt = 0;
    			}
        		
            }else{
            	//System.out.println("#iTotCnt# : " + iTotCnt + " / " + "rowData : " + rowData + " / " + "#sSlipNum# : " + sSlipNum);
    			
    			rowData.put("slipNum",	sSlipNum);
    			rowCntDtl += sapSlipUploadDAO.insertSapSlipDtl(rowData);
            }
			
			System.out.println("#beforeSlipNum# : " + beforeSlipNum + " / " + "#sSlipNum# : " + sSlipNum + " - " + iTotCnt); 
			
			
			if(!sSlipNum.equals(beforeSlipNum) && !beforeSlipNum.equals("")){
		
	//			if(rowCntMst > 0 && rowCntDtl > 0){
					try {
						//System.out.println("##### callProcedure Start #####");
						Map<String, Object> inParam = new HashMap<String, Object>();
						
						//입력값 Setting
						inParam.put("P_SLIP_NUM",		beforeSlipNum);
						inParam.put("P_SLIP_STATUS",	"J");
						
						//전표 생성시 분개번호 UPDATE procedure 호출
						//System.out.println("P_SLIP_NUM : " +beforeSlipNum);
						//System.out.println("loopCnt - " +loopCnt + ", sSlipNum2 : " + sSlipNum2);
						//전표가 나눠서 생성된 경우 처음 한번만 호출 20181030 김호석(프로시저 중복생성 방지 반영)
						//기존에 나눠서 전표생성된 경우 처음 프로시저만 업데이트 되고 나머지는 의미없는 호출(업데이트 0건), 첫 전표번호만 영업데이타에 업데이트됨 
						//if (loopCnt == 0) {
						if (sSlipNum2.equals("")) {		
							//환불,내부이용,기타입금대체같이 건별로 전표생성되는 전표인경우 매번 전표번호 업데이트
							//단, loopCnt가 0이 넘는 경우는 이전 전표가 나뉘어 생성된 전표이고 같은 CC 다음전표번호가 없는 경우이므로 loopCnt가 0인 경우만 프로시저 호출  
							if (loopCnt == 0) {
							retVal = sapSlipUploadDAO.callProcedure(inParam, "SP_SLA_SLIP_NUM_STATUS");
							strRtn		= String.valueOf(retVal.get("O_RTN"));
							strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
		            			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		                        System.out.println("########### 매번 전표 업데이트 " + beforeSlipNum + " - Rtn : " + strRtn + ", Msg : " + strRtnMsg);
		            			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
							}
							//
							loopCnt = 0;
	            			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	                        //System.out.println("########### loopCnt=0 초기화");
	            			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
							
						} else {
							if (loopCnt == 0) {
							//채권이관,입금,선수금발생 등 800줄 넘어가서 전표가 나눠서 생성되는 경우 처음만 전표번호 업데이트
								retVal = sapSlipUploadDAO.callProcedure(inParam, "SP_SLA_SLIP_NUM_STATUS");
								strRtn		= String.valueOf(retVal.get("O_RTN"));
								strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));	
		            			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		                        System.out.println("########### 처음만 업데이트 " + beforeSlipNum + " - Rtn : " + strRtn + ", Msg : " + strRtnMsg);
		            			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		            			
								//동일 CC로 나뉘어져 전표 생성 시에만 +1
								loopCnt = loopCnt + 1;
		            			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		                        //System.out.println("########### loopCnt + 1");
		            			//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
								
							}
						}
						
						//}
						
						//출력값 Setting						
						beforeSlipNum = sSlipNum;						
						//System.out.println("##### callProcedure End #####");
					} catch (Exception e) {
						logger.debug(e.getMessage());
						//strRtn    = "CALL PROCEDURE ERROR";
						//strRtnMsg = e.getMessage();
						throw e;
					}
//				}
		
			}else{				
				beforeSlipNum = sSlipNum;
			}
			//초기화
			beforeSlipType = nowSlipType;
			beforeTaxShetNum = nowTaxShetNum;
			beforeSusAltType = nowSusAltType;
			beforeCcCd = nowCcCd;
			beforeOrgCcCd = nowOrgCcCd;
			beforeReceiptNum = nowReceiptNum;
			beforeGiftBillingNum = nowGiftBillingNum;
			beforeAltNum = nowAltNum;
			
		}
		//마지막엔 한번 더 한다.
		System.out.println("최종 ---> #beforeSlipNum# : " + beforeSlipNum + " / " + "#sSlipNum# : " + sSlipNum);
		if(!beforeSlipNum.equals("")){
			
//			if(rowCntMst > 0 && rowCntDtl > 0){
				try {
//					System.out.println("##### callProcedure Start #####");
					Map<String, Object> inParam = new HashMap<String, Object>();
					
					//입력값 Setting
					inParam.put("P_SLIP_NUM",		beforeSlipNum);
					inParam.put("P_SLIP_STATUS",	"J");
					
					//전표 생성시 분개번호 UPDATE procedure 호출
					//System.out.println("2222");
					//System.out.println("P_SLIP_NUM : " +beforeSlipNum);
					//System.out.println("loopCnt - " +loopCnt + ", sSlipNum2 : " + sSlipNum2);
					//전표가 나눠서 생성된 경우 처음 한번만 호출 20181030 김호석(프로시저 중복생성 방지 반영)
					//기존에 나눠서 전표생성된 경우 처음 프로시저만 업데이트 되고 나머지는 의미없는 호출(업데이트 0건), 첫 전표번호만 영업데이타에 업데이트됨
					//if (loopCnt == 0) {
					if (sSlipNum2.equals("")) {		
						//나누서 전표가 생성되는 경우가 아니면 호출(위에서 첫번쩨 호출함)
						System.out.println("최종 SP_SLA_SLIP_NUM_STATUS 호출"); 
						retVal = sapSlipUploadDAO.callProcedure(inParam, "SP_SLA_SLIP_NUM_STATUS");
					}
					//}
					
					//출력값 Setting
					strRtn		= String.valueOf(retVal.get("O_RTN"));
					strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
                    System.out.println("########### 최종 전표 업데이트 " + beforeSlipNum + " - Rtn : " + strRtn + ", Msg : " + strRtnMsg);
					
					
//					System.out.println("##### callProcedure End #####");
				} catch (Exception e) {
					logger.debug(e.getMessage());
					//strRtn    = "CALL PROCEDURE ERROR";
					//strRtnMsg = e.getMessage();
					throw e;
				}
//			}
		}		
//		System.out.println("########### 전표생성 End ############");
		return strRtn + "|" + strRtnMsg;
	}

	
	/**
	 * 전표생성취소
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public String cancelSlipList(DataSetMap list) throws Exception {
		
		String nowSlipNum = "";
		String beforeSlipNum = "";
		String strRtn = "";
		String strRtnMsg = "";
		
		Map<String, Object> retVal = null;

//		System.out.println("########### 전표생성취소 Strat ############");

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);

			if(rowData.get("slipNum") != null) nowSlipNum = rowData.get("slipNum").toString();
			
			if(!beforeSlipNum.equals(nowSlipNum)){
				
				sapSlipUploadDAO.updateSapSlipMst(rowData);
				
				try {
//					System.out.println("##### callProcedure Start #####");
					Map<String, Object> inParam = new HashMap<String, Object>();
					
					//입력값 Setting
					inParam.put("P_SLIP_NUM",		nowSlipNum);
					inParam.put("P_SLIP_STATUS",	"Z");
					
					//전표 생성시 분개번호 UPDATE procedure 호출
					retVal = sapSlipUploadDAO.callProcedure(inParam, "SP_SLA_SLIP_NUM_CANCEL");
					
					//출력값 Setting
					strRtn		= String.valueOf(retVal.get("O_RTN"));
					strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
					
//					System.out.println("##### callProcedure End #####");
				} catch (Exception e) {
					logger.debug(e.getMessage());
					//strRtn    = "CALL PROCEDURE ERROR";
					//strRtnMsg = e.getMessage();
					throw e;
				}
			}
			//초기화
			beforeSlipNum = nowSlipNum;
		}
//		System.out.println("########### 전표생성취소 End ############");
		
		return strRtn + "|" + strRtnMsg;
	}

	/**
	 * SAP 월마감 여부를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSapClose(Map<String, Object> mapParam) throws Exception {
		
		return sapSlipUploadDAO.selectSapClose(mapParam);
	}
}
