package com.hwfs.ft.fdm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.fdm.dao.DeliveritemOtherAmtDivDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 입고 부대비 배부 정보를 등록 관리하는 DeliveritemOtherAmtDiv Service Implementation
 *
 * @ClassName DeliveritemOtherAmtDivServiceImpl.java
 * @Description DeliveritemOtherAmtDivServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16    kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.04.16
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/fdm/deliveritemOtherAmtDivService")
public class DeliveritemOtherAmtDivServiceImpl extends DefaultServiceImpl implements DeliveritemOtherAmtDivService {

    /** DeliveritemOtherAmtDivDAO Bean 생성 */
    @Resource(name = "/ft/fdm/deliveritemOtherAmtDivDAO")
    private DeliveritemOtherAmtDivDAO deliveritemOtherAmtDivDAO;


    /**
     * 입고 부대비 배부 정보를 등록 관리 목록을 조회한다.
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
        return deliveritemOtherAmtDivDAO.selectList(mapParam);
    }

    /**
     * 입고 부대비 배부 정보를 등록 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int saveList(DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        for (int i = 0 ; i < list.size() ; i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            //Insert 처리
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                insRowCnt += deliveritemOtherAmtDivDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += deliveritemOtherAmtDivDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += deliveritemOtherAmtDivDAO.delete(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
}
