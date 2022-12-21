package com.hwfs.fs.fsc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsc.dao.CateringAllcProcDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 케터링 지원배정 등록하는 CateringAllcProc Service Implementation
 * 
 * @ClassName CateringAllcProcServiceImpl.java
 * @Description CateringAllcProcServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    양효준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 양효준
 * @since 2015.03.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsc/cateringAllcProcService")
public class CateringAllcProcServiceImpl extends DefaultServiceImpl implements CateringAllcProcService {
	
	/** CateringAllcProcDAO Bean 생성 */
	@Resource(name = "/fs/fsc/cateringAllcProcDAO")
	private CateringAllcProcDAO cateringAllcProcDAO;
	

	/**
	 * 케터링 지원배정(행사) 등록 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCeleList(Map<String, Object> mapParam) throws Exception {
		return cateringAllcProcDAO.selectCeleList(mapParam);
	}
	
	/**
	 * 케터링 지원배정(조리인력) 등록 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCookHumanList(Map<String, Object> mapParam) throws Exception {
		return cateringAllcProcDAO.selectCookHumanList(mapParam);
	}
	
	/**
	 * 케터링 지원배정(기기/기물) 등록 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUtensilList(Map<String, Object> mapParam) throws Exception {
		return cateringAllcProcDAO.selectUtensilList(mapParam);
	}
	
	/**
	 * 케터링 지원배정(교육대상) 등록 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCookGuidList(Map<String, Object> mapParam) throws Exception {
		return cateringAllcProcDAO.selectCookGuidList(mapParam);
	}

	/**
	 * 케터링 지원배정 등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap parameterCele, DataSetMap parameterCookHuman, 
                        DataSetMap parameterUtensil, DataSetMap parameterCookGuid , LoginDTO loginDTO) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		
		//지원요청
		for (int i = 0 ; i < parameterCele.size() ; i++) {
			Map<String, Object> rowData = parameterCele.get(i);
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
		    if (rowType == DataSet.ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_INSERTED ) {
		    	rowData.put("allcYn", "Y");
		    	
		    	//배정처리
		    	if( rowData.get("newYn").equals("Y")) {
		    		
		    		insRowCnt += cateringAllcProcDAO.insertAllc(rowData);	//배정 등록
		    		updRowCnt += cateringAllcProcDAO.updateCele(rowData);	//지원요청 수정		
		    		insRowCnt += cateringAllcProcDAO.insertCele(rowData);	//지원요청 로그 저장
		    	}else{
		    		updRowCnt += cateringAllcProcDAO.updateAllc(rowData);	//배정 수정
		    	}
		    	
		    	
		    	if( rowData.get("allcSeq").equals("1") && !rowData.get("newYn").equals("Y")  
		    		 && (!rowData.get("celeNm").equals(rowData.get("orgCeleNm")) 
		    		 || !rowData.get("celeTermSdate").equals(rowData.get("orgCeleTermSdate"))
		    		 || !rowData.get("celeTermEdate").equals(rowData.get("orgCeleTermEdate")) 
		    		 || !LimsUtil.checkNull(rowData.get("dutyTime")).equals(LimsUtil.checkNull(rowData.get("orgDutyTime")))
		    		 || !rowData.get("supHumanStrengthCd").equals(rowData.get("orgSupHumanStrengthCd")) 
		    		 || !rowData.get("noMan").equals(rowData.get("orgNoMan"))
		    		 || !LimsUtil.checkNull(rowData.get("guestType")).equals(LimsUtil.checkNull(rowData.get("orgGuestType"))) 
		    		 || !LimsUtil.checkNull(rowData.get("spclfact")).equals(LimsUtil.checkNull(rowData.get("orgSpclfact")))
		    		 || !rowData.get("caterMenu").equals(rowData.get("orgCaterMenu")) 
		    		 || !rowData.get("caterUprice").equals(rowData.get("orgCaterUprice"))
		    		 || !LimsUtil.checkNull(rowData.get("prcgNm")).equals(LimsUtil.checkNull(rowData.get("orgPrcgNm"))) 
		    		 || !LimsUtil.checkNull(rowData.get("prcgTelno1")).equals(LimsUtil.checkNull(rowData.get("orgPrcgTelno1")))
		    		 || !LimsUtil.checkNull(rowData.get("prcgTelno2")).equals(LimsUtil.checkNull(rowData.get("orgPrcgTelno2"))) 
		    		 || !LimsUtil.checkNull(rowData.get("prcgTelno3")).equals(LimsUtil.checkNull(rowData.get("orgPrcgTelno3")))
		    		 || !LimsUtil.checkNull(rowData.get("chfsml")).equals(LimsUtil.checkNull(rowData.get("orgChfsml"))))		    				
	    		  ){
		    		updRowCnt += cateringAllcProcDAO.updateCele(rowData);	//지원요청 수정				
					insRowCnt += cateringAllcProcDAO.insertCele(rowData);	//지원요청 로그 저장
	    		}
			}
			
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cateringAllcProcDAO.deleteAllc(rowData);	//배정 삭제
			}
		}
		
		//조리인력
		for (int i = 0 ; i < parameterCookHuman.size() ; i++) {
			Map<String, Object> rowData = parameterCookHuman.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			
			//Update 처리
		    if (rowType == DataSet.ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_INSERTED ) {
		    	rowData.put("allcYn", "Y");
		    	
		    	//배정처리
		    	if( rowData.get("newYn").equals("Y")) {
		    				    		
		    		insRowCnt += cateringAllcProcDAO.insertAllc(rowData);	//배정 등록
		    		insRowCnt += cateringAllcProcDAO.insertCookHuman(rowData);	//지원요청 수정				
		    		updRowCnt += cateringAllcProcDAO.updateCookHuman(rowData);	//지원요청 로그 저장
		    	}else{
		    		updRowCnt += cateringAllcProcDAO.updateAllc(rowData);	//배정 수정
		    	}
		    	
		    	
		    	if( rowData.get("allcSeq").equals("1") && !rowData.get("newYn").equals("Y")
		    		 && (!rowData.get("supTermSdate").equals(rowData.get("orgSupTermSdate")) 
		    		 || !rowData.get("supTermEdate").equals(rowData.get("orgSupTermEdate"))
		    		 || !LimsUtil.checkNull(rowData.get("dutyTime")).equals(LimsUtil.checkNull(rowData.get("orgDutyTime"))) 
		    		 || !rowData.get("supHumanStrengthCd").equals(rowData.get("orgSupHumanStrengthCd"))
		    		 || !rowData.get("noMan").equals(rowData.get("orgNoMan")) 
		    		 || !LimsUtil.checkNull(rowData.get("requestReason")).equals(LimsUtil.checkNull(rowData.get("orgRequestReason"))))
	    		  ){
	    			insRowCnt += cateringAllcProcDAO.insertCookHuman(rowData);	//지원요청 수정				
	    			updRowCnt += cateringAllcProcDAO.updateCookHuman(rowData);	//지원요청 로그 저장
	    		}
			}
			
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cateringAllcProcDAO.deleteAllc(rowData);
			}
		}
		
		//기기/기물
		for (int i = 0 ; i < parameterUtensil.size() ; i++) {
			Map<String, Object> rowData = parameterUtensil.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			
			//Update 처리
		    if (rowType == DataSet.ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_INSERTED ) {
		    	rowData.put("apprvYn", "Y");
		    	
		    	//배정처리
		    	if( rowData.get("newYn").equals("Y")) {
		    		
		    		insRowCnt += cateringAllcProcDAO.insertAllc(rowData);	//배정 등록		   
		    		insRowCnt += cateringAllcProcDAO.insertUtensil(rowData);	//지원요청 수정
		    		updRowCnt += cateringAllcProcDAO.updateUtensil(rowData);	//지원요청 로그 저장				
		    	}else{
		    		updRowCnt += cateringAllcProcDAO.updateAllc(rowData);	//배정 수정
		    	}
		    	
		    	String requestQuantity = rowData.get("requestQuantity").toString();
		    	String orgRequestQuantity = rowData.get("orgRequestQuantity").toString()  ;
		   	 	
		    	if( !rowData.get("newYn").equals("Y")
		    		 && (!rowData.get("celeNm").equals(rowData.get("orgCeleNm")) 
		    		 || !rowData.get("lendTermSdate").equals(rowData.get("orgLendTermSdate"))
		    		 || !rowData.get("lendTermEdate").equals(rowData.get("orgLendTermEdate")) 
		    		 || !rowData.get("machineClassCd").equals(rowData.get("orgMachineClassCd"))
		    		 || !rowData.get("machineKindCd").equals(rowData.get("orgMachineKindCd")) 
		    		 || !rowData.get("machineCd").equals(rowData.get("orgMachineCd"))
		    		 || !rowData.get("rmaDate").equals(rowData.get("orgRmaDate"))
		    		 || Double.parseDouble(requestQuantity) != Double.parseDouble(orgRequestQuantity)
		    		 || !LimsUtil.checkNull(rowData.get("cntcNum")).equals(LimsUtil.checkNull(rowData.get("orgCntcNum")))
		    		 || !LimsUtil.checkNull(rowData.get("zipCode1")).equals(LimsUtil.checkNull(rowData.get("orgZipCode1"))) 
		    		 || !LimsUtil.checkNull(rowData.get("zipCode2")).equals(LimsUtil.checkNull(rowData.get("orgZipCode2")))
		    		 || !LimsUtil.checkNull(rowData.get("addr")).equals(LimsUtil.checkNull(rowData.get("orgAddr"))) 
		    		 || !LimsUtil.checkNull(rowData.get("transportMtod1")).equals(LimsUtil.checkNull(rowData.get("orgTransportMtod1")))
		    		 || !LimsUtil.checkNull(rowData.get("transportMtod2")).equals(LimsUtil.checkNull(rowData.get("orgTransportMtod2"))))
		    		  ){
	    			insRowCnt += cateringAllcProcDAO.insertUtensil(rowData);	//지원요청 수정				
		    		updRowCnt += cateringAllcProcDAO.updateUtensil(rowData);	//지원요청 로그 저장
	    		}
			}
		    
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cateringAllcProcDAO.deleteAllc(rowData);
			}
			
		}
		
		//교육대상
		for (int i = 0 ; i < parameterCookGuid.size() ; i++) {
			Map<String, Object> rowData = parameterCookGuid.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
		    if (rowType == DataSet.ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_INSERTED ) {
		    	rowData.put("allcYn", "Y");
		    	
		    	//배정처리
		    	if( rowData.get("newYn").equals("Y")) {
		    		
		    		insRowCnt += cateringAllcProcDAO.insertAllc(rowData);	//배정 등록
		    		insRowCnt += cateringAllcProcDAO.insertCookGuid(rowData);	//지원요청 수정				
		    		updRowCnt += cateringAllcProcDAO.updateCookGuid(rowData);	//지원요청 로그 저장	
					
		    	}else{
		    		updRowCnt += cateringAllcProcDAO.updateAllc(rowData);	//배정 수정
		    	}
		    	
		    	
		    	if( rowData.get("allcSeq").equals("1")  && !rowData.get("newYn").equals("Y") 
		    		 &&  (!rowData.get("guidTermSdate").equals(rowData.get("orgGuidTermSdate")) 
		    		 ||  !rowData.get("guidTermEdate").equals(rowData.get("orgGuidTermEdate"))
		    		 ||  !LimsUtil.checkNull(rowData.get("guidTime")).equals(LimsUtil.checkNull(rowData.get("orgGuidTime"))) 
		    		 ||  !rowData.get("eduTrglst").equals(rowData.get("orgEduTrglst"))
		    		 ||  !LimsUtil.checkNull(rowData.get("noMan")).equals(LimsUtil.checkNull(rowData.get("orgNoMan"))) 
		    		 ||  !LimsUtil.checkNull(rowData.get("requestFact")).equals(LimsUtil.checkNull(rowData.get("orgRequestFact"))))
		    		  ){
	    			insRowCnt += cateringAllcProcDAO.insertCookGuid(rowData);	//지원요청 수정				
		    		updRowCnt += cateringAllcProcDAO.updateCookGuid(rowData);	//지원요청 로그 저장
	    		}
				
			}
		    
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cateringAllcProcDAO.deleteAllc(rowData);
			}
		}
				
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
