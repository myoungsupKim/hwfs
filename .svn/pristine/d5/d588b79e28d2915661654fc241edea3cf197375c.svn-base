package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sm.saa.dao.AccdArOccurReptDAO;
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 사고채권발생보고하는 AccdArOccurRept Service Implementation
 *
 * @ClassName AccdArOccurReptServiceImpl.java
 * @Description AccdArOccurReptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.29
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/saa/accdArOccurReptService")
public class AccdArOccurReptServiceImpl extends DefaultServiceImpl implements AccdArOccurReptService {

    /** AttachFile Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /** AccdArOccurReptDAO Bean 생성 */
    @Resource(name = "/sm/saa/accdArOccurReptDAO")
    private AccdArOccurReptDAO accdArOccurReptDAO;

    /** GwIfDAO Bean 생성 */
    @Resource(name = "/sc/cmn/gwIfDAO")
    private GwIfDAO gwIfDAO;

    /**
     * 사고채권발생보고 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return accdArOccurReptDAO.selectList(parameter);
    }

    /**
     * 식재 업장 정보를 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectSaupNoList(Map<String, Object> parameter) throws Exception {
    	return accdArOccurReptDAO.selectSaupNoList(parameter);
    }
    
  //주소를 처리하기 위한 공통 Service
  	@Resource(name = "/sc/cmn/addrSearchService")
  	private AddrSearchService addressService;

    /**
     * 업장정보를 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectUpjang(Map<String, Object> parameter) throws Exception {
        return accdArOccurReptDAO.selectUpjang(parameter);
    }

    /**
     * 거래처 채권 금액(급식)을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectCustInfo(Map<String, Object> parameter) throws Exception {
    	return accdArOccurReptDAO.selectCustInfo(parameter);
    }
   
    /**
     * 거래처 채권 금액(식재)을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectCustInfoFms(Map<String, Object> parameter) throws Exception {
    	return accdArOccurReptDAO.selectCustInfoFms(parameter);
    }

    /**
     * 채무자 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectDebt(Map<String, Object> parameter) throws Exception {
        return accdArOccurReptDAO.selectDebt(parameter);
    }

    /**
     * 담보 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectDambo(Map<String, Object> parameter) throws Exception {
        return accdArOccurReptDAO.selectDambo(parameter);
    }

    /**
     * 법적조치 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectLegal(Map<String, Object> parameter) throws Exception {
        return accdArOccurReptDAO.selectLegal(parameter);
    }

    /**
     * 거래내역 헤더 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectHdrDealDesc(Map<String, Object> parameter) throws Exception {
        return accdArOccurReptDAO.selectHdrDealDesc(parameter);
    }

    /**
     * 거래내역 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectDealDesc(Map<String, Object> parameter) throws Exception {
        return accdArOccurReptDAO.selectDealDesc(parameter);
    }
    
    /**
     * 거래내역 헤더 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectHdrDealDescFs(Map<String, Object> parameter) throws Exception {
    	return accdArOccurReptDAO.selectHdrDealDescFs(parameter);
    }
    
    /**
     * 거래내역 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectDealDescFs(Map<String, Object> parameter) throws Exception {
    	return accdArOccurReptDAO.selectDealDescFs(parameter);
    }

    /**
     * 사고채권발생보고 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param list
     * @param debt
     * @param dambo
     * @param legal
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int saveList(DataSetMap list, DataSetMap debt, DataSetMap dambo, DataSetMap legal, DataSetMap file, LoginDTO loginDTO) throws Exception {
        int insRowCnt      = 0;
        int updRowCnt      = 0;
        int delRowCnt      = 0;
        String accdArRegYn = "";
        String strRefSeq   = "";  //첨부참조일련번호
        String accdArNum   = "";

        //첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
        if(file.size() > 0) {
            strRefSeq = attachFileService.save(file, propertiesService.getString("sm.file.path"), false);
        }

        for (int i = 0 ; i < list.size() ; i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            accdArRegYn = LimsUtil.checkNull(rowData.get("accdArRegYn").toString());

            if (!"".equals(strRefSeq)) {
                rowData.put("fileId", strRefSeq);
            }

            if (rowType == DataSet.ROW_TYPE_INSERTED) {                 //Insert 처리
                RecordSet reMstSeq = accdArOccurReptDAO.selectAccdCustMstSeq(rowData);

                accdArNum = reMstSeq.get(0).getString("seq");
                rowData.put("seq", accdArNum);
                rowData.put("accdArNum", accdArNum);

                insRowCnt += accdArOccurReptDAO.insertAccdCustMst(rowData);
                insRowCnt += accdArOccurReptDAO.insertAccdAr(rowData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {           //Update 처리
                accdArNum   = LimsUtil.checkNull(rowData.get("seq"));

                updRowCnt += accdArOccurReptDAO.updateAccdCustMst(rowData);

                if("Y".equals(accdArRegYn)) {
                    insRowCnt += accdArOccurReptDAO.insertAccdAr(rowData);
                } else {
                    updRowCnt += accdArOccurReptDAO.updateAccdAr(rowData);
                }
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdArOccurReptDAO.deleteAccdCustMst(rowData);
                delRowCnt += accdArOccurReptDAO.deleteAccdAr(rowData);
            }
        }

        // 채무자
        for (int i = 0 ; i < debt.size() ; i++) {
            Map<String, Object> rowData = debt.get(i);
            int rowType   = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            String arNum  = LimsUtil.checkNull(rowData.get("accdArNum"));
            
         // 주소 처리
         			Map<String, Object> rtn = addressService.setAddress(rowData, "addrInfo", loginDTO.getSabun());

            if (rowType == DataSet.ROW_TYPE_INSERTED) {                 //Insert 처리
                if("".equals(arNum)) {
                    rowData.put("accdArNum", accdArNum);
                }

                insRowCnt += accdArOccurReptDAO.insertAccdArDebtor(rowData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {           //Update 처리
                updRowCnt += accdArOccurReptDAO.updateAccdArDebtor(rowData);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdArOccurReptDAO.deleteAccdArDebtor(rowData);
            }
        }

        // 담보
        for (int i = 0 ; i < dambo.size() ; i++) {
            Map<String, Object> rowData = dambo.get(i);
            int rowType      = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            String damboType = LimsUtil.checkNull(rowData.get("damboType"));

            if (rowType == DataSet.ROW_TYPE_UPDATED) {                 //Update 처리
                if("RE".equals(damboType)) {           // 부동산정보
                    updRowCnt += accdArOccurReptDAO.updateRealEstate(rowData);
                } if("SI".equals(damboType)) {         // 보증보험정보
                    updRowCnt += accdArOccurReptDAO.updateGuaranteeInsur(rowData);
                } if("HS".equals(damboType)) {         // 인보증정보
                    updRowCnt += accdArOccurReptDAO.updateGuarantor(rowData);
                } if("CS".equals(damboType)) {         // 현금보증정보
                    updRowCnt += accdArOccurReptDAO.updateCashGuarantee(rowData);
                } if("RP".equals(damboType)) {         // 질권정보
                    updRowCnt += accdArOccurReptDAO.updatePledge(rowData);
                } if("TC".equals(damboType)) {         // 채권양도정보
                    updRowCnt += accdArOccurReptDAO.updateAccRcvAlnt(rowData);
                }
            }
        }

        // 법적조치
        for (int i = 0 ; i < legal.size() ; i++) {
            Map<String, Object> rowData = legal.get(i);
            int rowType   = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            String arNum  = LimsUtil.checkNull(rowData.get("accdArNum"));

            if (rowType == DataSet.ROW_TYPE_INSERTED) {                 //Insert 처리
                if("".equals(arNum)) {
                    rowData.put("accdArNum", accdArNum);
                }

                insRowCnt += accdArOccurReptDAO.insertAccdArLegalMrmt(rowData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {           //Update 처리
                updRowCnt += accdArOccurReptDAO.updateAccdarlegalMrmt(rowData);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdArOccurReptDAO.deleteAccdarlegalMrmt(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
    
    /**
     * 사고채권발생보고 DataSetMap의 데이터를 Delete 처리한다.
     *
     * @param list
     * @param debt
     * @param dambo
     * @param legal
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int deleteList(DataSetMap list, DataSetMap file, LoginDTO loginDTO) throws Exception {
      
        int delRowCnt      = 0;
        String accdArRegYn = "";
        String strRefSeq   = "";  //첨부참조일련번호
        String accdArNum   = "";

        //첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
        if(file.size() > 0) {
            strRefSeq = attachFileService.save(file, propertiesService.getString("sm.file.path"), false);
        }

        for (int i = 0 ; i < list.size() ; i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            accdArRegYn = LimsUtil.checkNull(rowData.get("accdArRegYn").toString());

            if (!"".equals(strRefSeq)) {
                rowData.put("fileId", strRefSeq);
            }

             if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdArOccurReptDAO.deleteAccdCustMst(rowData);
                delRowCnt += accdArOccurReptDAO.deleteAccdAr(rowData);
            }
        }
        return delRowCnt;
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
                updateRowCnt += accdArOccurReptDAO.updateSign(rowData);

                //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                gwIfDAO.saveSignInfo(rowData);
            }
        }

        return updateRowCnt;
    }
}
