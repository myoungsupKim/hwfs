package com.hwfs.ft.fsi.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.fsi.dao.GvrntaxRateMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
* 국가,품목,기간별로 관세율을 관리하는 GvrntaxRateMgmt Service Implementation
*
* @ClassName GvrntaxRateMgmtServiceImpl.java
* @Description GvrntaxRateMgmtServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.03.12    김종준        최초생성
* </pre>
* @author FC종합전산구축 : 식재도매 김종준
* @since 2015.03.12
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/ft/fsi/gvrntaxRateMgmtService")
public class GvrntaxRateMgmtServiceImpl extends DefaultServiceImpl implements GvrntaxRateMgmtService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /** GvrntaxRateMgmtDAO Bean 생성 */
    @Resource(name = "/ft/fsi/gvrntaxRateMgmtDAO")
    private GvrntaxRateMgmtDAO gvrntaxRateMgmtDAO;

    /**
     * 기간별 관세율관리 목록을 조회한다.
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
        return gvrntaxRateMgmtDAO.selectList(mapParam);
    }

    /**
     * 시작일자, 종료일자 포함여부 체크
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
    public RecordSet checkDateList(Map<String, Object> mapParam) throws Exception {
        return gvrntaxRateMgmtDAO.checkDateList(mapParam);
    }

    /**
     * 기간별 관세율관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public List<Map<String, Object>> saveList(DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap();

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                rowData.put("procFlag", "I");
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                rowData.put("procFlag", "U");
            }

            if (rowType != DataSet.ROW_TYPE_DELETED) {
                RecordSet dupList = gvrntaxRateMgmtDAO.checkDateList(rowData);
                logger.info("dupList.size()  :::" + dupList.size());
                if (dupList.size() > 0) {
                    map.put("procCnt", 0); //실행건 전달
                    map.put("dupList", dupList); //일자 중복 리스트 return
                    listMap.add(map);
                    return listMap;
                    //throw processException("ft.fsi.fail.dateChkDup");
                }
            }

            //Insert 처리
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                insRowCnt += gvrntaxRateMgmtDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += gvrntaxRateMgmtDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += gvrntaxRateMgmtDAO.delete(rowData);
            }
        }
        map.put("procCnt", insRowCnt + updRowCnt + delRowCnt); //실행건 전달
        listMap.add(map);
        //		return insRowCnt + updRowCnt + delRowCnt;
        return listMap;
    }

    /**
     * 기간별 관세율관리 목록을 조회한다.
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
    public RecordSet selectGvrntaxRatePop(Map<String, Object> mapParam) throws Exception {
        return gvrntaxRateMgmtDAO.selectGvrntaxRatePop(mapParam);
    }

}
