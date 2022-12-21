package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fse.dao.EventResultRegMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 이벤트 결과등록 관리하는 EventResultRegMgnt Service Implementation
 *
 * @ClassName EventResultRegMgntServiceImpl.java
 * @Description EventResultRegMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.17
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fse/eventResultRegMgntService")
public class EventResultRegMgntServiceImpl extends DefaultServiceImpl implements EventResultRegMgntService {

    /** EventResultRegMgntDAO Bean 생성 */
    @Resource(name = "/fs/fse/eventResultRegMgntDAO")
    private EventResultRegMgntDAO eventResultRegMgntDAO;

    /** EventProcessInfoMgntService Bean 생성 */
    @Resource(name = "/fs/fse/eventProcessInfoMgntService")
    private EventProcessInfoMgntService eventProcessInfoMgntService;

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
        return eventResultRegMgntDAO.selectCboList(parameter);
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
        return eventResultRegMgntDAO.selectThemeList(parameter);
    }

    /**
     * 이벤트 결과등록 관리 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return eventResultRegMgntDAO.selectList(parameter);
    }

    /**
     * 결과정보 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
    */
    @Override
    public RecordSet selectResult(Map<String, Object> parameter) throws Exception {
        return eventResultRegMgntDAO.selectResult(parameter);
    }

    /**
     * 이벤트 결과등록 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param form
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public int saveList(DataSetMap form, DataSetMap file) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        String strRefSeq = "";  //첨부참조일련번호

        //첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
        if (file.size() > 0) {
            strRefSeq = eventProcessInfoMgntService.save(file, propertiesService.getString("fs.file.path"), false);
        }
        
        //이벤트 등록 폼
        if (form.size() > 0) {
            Map<String, Object> rowFormData = form.get(0);
            int rowFormType = ((Integer)rowFormData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            
            if (!"".equals(strRefSeq)) {
                rowFormData.put("fileId", strRefSeq);
            }
            
            if (rowFormType == DataSet.ROW_TYPE_UPDATED) {                          //Update 처리
                updRowCnt += eventResultRegMgntDAO.updateForm(rowFormData);
            } else if (rowFormType == DataSet.ROW_TYPE_INSERTED) {                  //Insert 처리
                insRowCnt += eventResultRegMgntDAO.insertForm(rowFormData);
            } else {
                if (!"".equals(strRefSeq)) {
                    updRowCnt += eventResultRegMgntDAO.updateForm(rowFormData);
                }
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
}
