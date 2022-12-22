package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fso.dao.AccOrderPropReptDAO;
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 수주 및 운영품의하는 AccOrderPropRept Service Implementation
 * 
 * @ClassName AccOrderPropReptServiceImpl.java
 * @Description AccOrderPropReptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.01    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.06.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/accOrderPropReptService")
public class AccOrderPropReptServiceImpl extends DefaultServiceImpl implements AccOrderPropReptService {
	
	/** AccOrderPropReptDAO Bean 생성 */
	@Resource(name = "/fs/fso/accOrderPropReptDAO")
	private AccOrderPropReptDAO accOrderPropReptDAO;
	
	/** GwIfDAO Bean 생성 */
    @Resource(name = "/sc/cmn/gwIfDAO")
    private GwIfDAO gwIfDAO;
	
	/**
	 * 물건목록을 조회한다.
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
	public RecordSet selectObjectList(Map<String, Object> mapParam) throws Exception {
		return accOrderPropReptDAO.selectObjectList(mapParam);
	}

	/**
	 * 수주 및 운영품의 목록을 조회한다.
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
	public RecordSet selectAccOrderOpProposal(Map<String, Object> mapParam) throws Exception {
		return accOrderPropReptDAO.selectAccOrderOpProposal(mapParam);
	}
	
	/**
	 * 수주(운영) 손익추정보고서 등록여부를 조회한다.
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
	public RecordSet selectOpProposalChk(Map<String, Object> mapParam) throws Exception {
		return accOrderPropReptDAO.selectOpProposalChk(mapParam);
	}

	/**
	 * 수주 및 운영품의 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveAccOrderOpProposal(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += accOrderPropReptDAO.insertAccOrderOpProposal(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += accOrderPropReptDAO.updateAccOrderOpProposal(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += accOrderPropReptDAO.deleteAccOrderOpProposal(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
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
                updateRowCnt += accOrderPropReptDAO.updateSign(rowData);

                //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                rowData.put("signInstanceId", rowData.get("elctnsignKey"));
                gwIfDAO.saveSignInfo(rowData);
            }
        }

        return updateRowCnt;
    }
}
