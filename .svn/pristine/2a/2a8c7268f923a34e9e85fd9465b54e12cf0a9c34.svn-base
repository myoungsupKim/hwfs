package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.saa.dao.AccdDamboInfoRegDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 담보정보등록하는 AccdDamboInfoReg Service Implementation
 *
 * @ClassName AccdDamboInfoRegServiceImpl.java
 * @Description AccdDamboInfoRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.24
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/saa/accdDamboInfoRegService")
public class AccdDamboInfoRegServiceImpl extends DefaultServiceImpl implements AccdDamboInfoRegService {

    /** AccdDamboInfoRegDAO Bean 생성 */
    @Resource(name = "/sm/saa/accdDamboInfoRegDAO")
    private AccdDamboInfoRegDAO accdDamboInfoRegDAO;

    /**
     * 담보정보 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return accdDamboInfoRegDAO.selectList(parameter);
    }

    /**
     * 메인업장을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectMainUpjang(Map<String, Object> parameter) throws Exception {
        return accdDamboInfoRegDAO.selectMainUpjang(parameter);
    }

    /**
     * 부동산 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectRealEstate(Map<String, Object> parameter) throws Exception {
        return accdDamboInfoRegDAO.selectRealEstate(parameter);
    }

    /**
     * 보증보험 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectGuaranteeInsur(Map<String, Object> parameter) throws Exception {
        return accdDamboInfoRegDAO.selectGuaranteeInsur(parameter);
    }

    /**
     * 인보증 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectGuarantor(Map<String, Object> parameter) throws Exception {
        return accdDamboInfoRegDAO.selectGuarantor(parameter);
    }

    /**
     * 현금보증 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectCashGuarantee(Map<String, Object> parameter) throws Exception {
        return accdDamboInfoRegDAO.selectCashGuarantee(parameter);
    }

    /**
     * 질권 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectPledge(Map<String, Object> parameter) throws Exception {
        return accdDamboInfoRegDAO.selectPledge(parameter);
    }

    /**
     * 채권양도 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectAccRcvAlnt(Map<String, Object> parameter) throws Exception {
        return accdDamboInfoRegDAO.selectAccRcvAlnt(parameter);
    }

    /**
     * 담보정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param realEstate
     * @param guaranteeInsur
     * @param guarantor
     * @param cashGuarantee
     * @param pledge
     * @param accRcvAlnt
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
    public int saveList(DataSetMap realEstate, DataSetMap guaranteeInsur, DataSetMap guarantor, DataSetMap cashGuarantee, DataSetMap pledge, DataSetMap accRcvAlnt) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        // 부동산
        for (int i = 0 ; i < realEstate.size() ; i++) {
            Map<String, Object> rowData = realEstate.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {                 //Insert 처리
                insRowCnt += accdDamboInfoRegDAO.insertRealEstate(rowData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {           //Update 처리
                updRowCnt += accdDamboInfoRegDAO.updateRealEstate(rowData);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdDamboInfoRegDAO.deleteRealEstate(rowData);
            }
        }

        // 보증보험
        for (int i = 0 ; i < guaranteeInsur.size() ; i++) {
            Map<String, Object> rowData = guaranteeInsur.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {                 //Insert 처리
                insRowCnt += accdDamboInfoRegDAO.insertGuaranteeInsur(rowData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {           //Update 처리
                updRowCnt += accdDamboInfoRegDAO.updateGuaranteeInsur(rowData);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdDamboInfoRegDAO.deleteGuaranteeInsur(rowData);
            }
        }

        // 인보증
        for (int i = 0 ; i < guarantor.size() ; i++) {
            Map<String, Object> rowData = guarantor.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {                 //Insert 처리
                insRowCnt += accdDamboInfoRegDAO.insertGuarantor(rowData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {           //Update 처리
                updRowCnt += accdDamboInfoRegDAO.updateGuarantor(rowData);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdDamboInfoRegDAO.deleteGuarantor(rowData);
            }
        }

        // 현금보증
        for (int i = 0 ; i < cashGuarantee.size() ; i++) {
            Map<String, Object> rowData = cashGuarantee.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {                 //Insert 처리
                insRowCnt += accdDamboInfoRegDAO.insertCashGuarantee(rowData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {           //Update 처리
                updRowCnt += accdDamboInfoRegDAO.updateCashGuarantee(rowData);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdDamboInfoRegDAO.deleteCashGuarantee(rowData);
            }
        }

        // 질권
        for (int i = 0 ; i < pledge.size() ; i++) {
            Map<String, Object> rowData = pledge.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {                 //Insert 처리
                insRowCnt += accdDamboInfoRegDAO.insertPledge(rowData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {           //Update 처리
                updRowCnt += accdDamboInfoRegDAO.updatePledge(rowData);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdDamboInfoRegDAO.deletePledge(rowData);
            }
        }

        // 채권양도
        for (int i = 0 ; i < accRcvAlnt.size() ; i++) {
            Map<String, Object> rowData = accRcvAlnt.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {                 //Insert 처리
                insRowCnt += accdDamboInfoRegDAO.insertAccRcvAlnt(rowData);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {           //Update 처리
                updRowCnt += accdDamboInfoRegDAO.updateAccRcvAlnt(rowData);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {           //Delete 처리
                delRowCnt += accdDamboInfoRegDAO.deleteAccRcvAlnt(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
}
