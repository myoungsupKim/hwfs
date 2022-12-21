package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sm.saa.dao.SalsNonOccurReasonReptDAO;
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 매출미발생사유 및 계획을 관리하는 SalsNonOccurReasonRept Service Implementation
 * 
 * @ClassName SalsNonOccurReasonReptServiceImpl.java
 * @Description SalsNonOccurReasonReptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/saa/salsNonOccurReasonReptService")
public class SalsNonOccurReasonReptServiceImpl extends DefaultServiceImpl implements SalsNonOccurReasonReptService {
	
	/** SalsNonOccurReasonReptDAO Bean 생성 */
	@Resource(name = "/sm/saa/salsNonOccurReasonReptDAO")
	private SalsNonOccurReasonReptDAO salsNonOccurReasonReptDAO;
	
	/** AttachFile Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;
    
    /** GwIfDAO Bean 생성 */
    @Resource(name = "/sc/cmn/gwIfDAO")
    private GwIfDAO gwIfDAO;

	/**
	 * 매출미발생사유 및 계획 목록을 조회한다.
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
	public RecordSet selectCustList(Map<String, Object> mapParam) throws Exception {
		return salsNonOccurReasonReptDAO.selectCustList(mapParam);
	}
	public RecordSet selectDamboList(Map<String, Object> mapParam) throws Exception {
		return salsNonOccurReasonReptDAO.selectDamboList(mapParam);
	}
	public RecordSet selectArNonoccurList(Map<String, Object> mapParam) throws Exception {
		return salsNonOccurReasonReptDAO.selectArNonoccurList(mapParam);
	}
	public RecordSet selectHdrDealDesc(Map<String, Object> parameter) throws Exception {
        return salsNonOccurReasonReptDAO.selectHdrDealDesc(parameter);
    }
	public RecordSet selectDealDescList(Map<String, Object> mapParam) throws Exception {
		return salsNonOccurReasonReptDAO.selectDealDescList(mapParam);
	}
	public RecordSet selectHdrDealDescFs(Map<String, Object> parameter) throws Exception {
		return salsNonOccurReasonReptDAO.selectHdrDealDescFs(parameter);
	}
	public RecordSet selectDealDescListFs(Map<String, Object> mapParam) throws Exception {
		return salsNonOccurReasonReptDAO.selectDealDescListFs(mapParam);
	}

	/**
	 * 매출미발생사유 및 계획 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap damboList, DataSetMap arNonoccurList, DataSetMap fileList) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		//첨부참조일련번호
		String strRefSeq = "";	
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		if(fileList.size() > 0) {
			strRefSeq = attachFileService.save(fileList, propertiesService.getString("sm.file.path"), false);
		}
		for (int i = 0 ; i < damboList.size() ; i++) {
			Map<String, Object> rowData = damboList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			String damboType = LimsUtil.checkNull(rowData.get("damboType"));
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				if(damboType.equals("RE")){
					updRowCnt += salsNonOccurReasonReptDAO.updateRealEstate(rowData);
				}else if(damboType.equals("SI")){
					updRowCnt += salsNonOccurReasonReptDAO.updateGuaranteeInsur(rowData);
				}else if(damboType.equals("HS")){
					updRowCnt += salsNonOccurReasonReptDAO.updateGuarantor(rowData);
				}else if(damboType.equals("CS")){
					updRowCnt += salsNonOccurReasonReptDAO.updateCashGuarantee(rowData);
				}else if(damboType.equals("RP")){
					updRowCnt += salsNonOccurReasonReptDAO.updatePledge(rowData);
				}else if(damboType.equals("TC")){
					updRowCnt += salsNonOccurReasonReptDAO.updateAccRcvAlnt(rowData);
				}
			}
		}
		
		for (int i = 0 ; i < arNonoccurList.size() ; i++) {
			Map<String, Object> rowData = arNonoccurList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if (!"".equals(strRefSeq))
				rowData.put("fileId", strRefSeq);
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += salsNonOccurReasonReptDAO.insertArNonoccur(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += salsNonOccurReasonReptDAO.updateArNonoccur(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += salsNonOccurReasonReptDAO.deleteArNonoccur(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 매출미발생사유 및 계획 DataSetMap의 데이터를Delete 처리한다.
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
	public int deleteList(DataSetMap arNonoccurList, DataSetMap fileList) throws Exception {
		
		int delRowCnt = 0;
		
		//첨부참조일련번호
		String strRefSeq = "";	
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		if(fileList.size() > 0) {
			strRefSeq = attachFileService.save(fileList, propertiesService.getString("sm.file.path"), false);
		}
				
		for (int i = 0 ; i < arNonoccurList.size() ; i++) {
			Map<String, Object> rowData = arNonoccurList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if (!"".equals(strRefSeq))
				rowData.put("fileId", strRefSeq);
			
			
			//Delete 처리.
			if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += salsNonOccurReasonReptDAO.deleteArNonoccur(rowData);
			}
		}
		
		return  delRowCnt;
	}
	

    /**
     * 전자결재정보를 Update 처리한다.
     * <pre>
     * - 업무 테이블에 Instance ID Update
     * - 결재정보 공통 테이블에 결재정보 Insert or Update
     * </pre>
     *
     * @param list
     * @return
     * @throws Exception
     * @see com.hwfs.guide.sample.service.GuideSampleService#saveSign(hone.online.xplatform.map.DataSetMap)
    */
    @SuppressWarnings("unchecked")
    public int saveSignInfo(DataSetMap list) throws Exception {
        int updateRowCnt = 0;

        for (int i = 0 ; i < list.size() ; i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            //수정을 수행합니다. (Update만 존재)
            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                //업무 테이블에 결재INSTANCE_ID update
                updateRowCnt += salsNonOccurReasonReptDAO.updateSign(rowData);

                //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                gwIfDAO.saveSignInfo(rowData);
            }
        }

        return updateRowCnt;
    }
}
