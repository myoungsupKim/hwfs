package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.fs.fse.dao.EventProcessApprvMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 이벤트 등록 관리자 승인하는 EventProcessApprvMgnt Service Implementation
 *
 * @ClassName EventProcessApprvMgntServiceImpl.java
 * @Description EventProcessApprvMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : FC종합전산구축 :  통합영업 최종덕
 * @since 2015.04.14
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fse/eventProcessApprvMgntService")
public class EventProcessApprvMgntServiceImpl extends DefaultServiceImpl implements EventProcessApprvMgntService {

    /** EventProcessApprvMgntDAO Bean 생성 */
    @Resource(name = "/fs/fse/eventProcessApprvMgntDAO")
    private EventProcessApprvMgntDAO eventProcessApprvMgntDAO;

    /** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;

    /** UUIdGenService */
    @Resource(name = "idGenUUIdService")
    protected UUIdGenService idGenUUIdService;

    
    /**
     * 이벤트 분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectCboList(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectCboList(parameter);
    }

    /**
     * 이벤트 테마 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectThemeList(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectThemeList(parameter);
    }

    /**
     * 이벤트 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectList(parameter);
    }

    /**
     * 이벤트 Master 정보를 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectEventMst(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectEventMst(parameter);
    }

    /**
     * 이벤트 Master 진행정보를 조회한다.(Master 진행절차)
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectMstProgress(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectMstProgress(parameter);
    }

    /**
     * 기기/포장제 정보을 조회한다.(Master 기기/포장제)
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectMstUtensil(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectMstUtensil(parameter);
    }
    
    /**
     * 서버 사진을 조회한다. (Master 첨부파일)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    @Override
    public RecordSet selectImgList(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectImgList(parameter);
    }    
    
    
    /**
     * 이벤트 신청 정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
    */
    @Override
    public RecordSet selectEventReq(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectEventReq(parameter);
    }

    /**
     * 이벤트 진행정보 관리 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    @Override
    public RecordSet selectProgress(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectProgress(parameter);
    }

    /**
     * 기기 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
    */
    @Override
    public RecordSet selectInforeg(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectInforeg(parameter);
    }

    /**
     * 사업장 기기 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
    */
    @Override
    public RecordSet selectUpjangutensil(Map<String, Object> parameter) throws Exception {
        return eventProcessApprvMgntDAO.selectUpjangutensil(parameter);
    }

    
    /**
     * 이벤트 master DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param form
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
    public int saveMstList(DataSetMap form) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        Map<String, Object> rowFormData = form.get(0);
        int rowType = ((Integer)rowFormData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

        //Update 처리
        if (rowType == DataSet.ROW_TYPE_UPDATED) {
            updRowCnt += eventProcessApprvMgntDAO.updateMst(rowFormData);
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 이벤트 신청정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param form
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int saveReqList(DataSetMap form) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        Map<String, Object> rowFormData = form.get(0);
        int rowType = ((Integer)rowFormData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

        //Update 처리
        if (rowType == DataSet.ROW_TYPE_UPDATED) {
            updRowCnt += eventProcessApprvMgntDAO.updateReq(rowFormData);
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
}
