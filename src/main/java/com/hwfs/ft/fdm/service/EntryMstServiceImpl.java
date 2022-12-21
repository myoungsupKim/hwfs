package com.hwfs.ft.fdm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.fdm.dao.EntryItemDetailDAO;
import com.hwfs.ft.fdm.dao.EntryMstDAO;
import com.hwfs.ft.fsi.dao.GvrntaxRateMgmtDAO;
import com.hwfs.ft.fsi.dao.WhbyItembyChargAmtDAO;
import com.hwfs.ft.ftp.dao.PoOrderItemDetailDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 관세비용 및 입고예정정보를 등록 관리하는 EntryMst Service Implementation
 *
 * @ClassName EntryMstServiceImpl.java
 * @Description EntryMstServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.13    kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.04.13
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/fdm/entryMstService")
public class EntryMstServiceImpl extends DefaultServiceImpl implements EntryMstService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** EntryMstDAO Bean 생성 */
    @Resource(name = "/ft/fdm/entryMstDAO")
    private EntryMstDAO entryMstDAO;

    @Resource(name = "/ft/fdm/entryItemDetailDAO")
    private EntryItemDetailDAO entryItemDetailDAO;

    @Resource(name = "/ft/ftp/poOrderItemDetailDAO")
    private PoOrderItemDetailDAO poOrderItemDetailDAO;

    /** WhbyItembyChargAmtDAO Bean 생성 */
    @Resource(name = "/ft/fsi/whbyItembyChargAmtDAO")
    private WhbyItembyChargAmtDAO whbyItembyChargAmtDAO;

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
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
        return entryMstDAO.selectList(mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
                insRowCnt += entryMstDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += entryMstDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += entryMstDAO.delete(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 수입면허 품목선정 POP-UP 목록 목록을 조회한다.
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
    public RecordSet selectItemInfoSaveSearchPop(Map<String, Object> mapParam) throws Exception {
        return entryMstDAO.selectItemInfoSaveSearchPop(mapParam);
    }


    /**
     * 수입면허 품목선정 POP-UP item 목록을 조회한다.
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
    public RecordSet selectItemInfoSaveSearchPop2(Map<String, Object> mapParam) throws Exception {
        return entryMstDAO.selectItemInfoSaveSearchPop2(mapParam);
    }

    /**
     * 수입면허 품목선정 POP-UP 가입고 목록 목록을 조회한다.
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
    public RecordSet selectItemInfoSaveReceiveSearchPop(Map<String, Object> mapParam) throws Exception {
        return entryMstDAO.selectItemInfoSaveReceiveSearchPop(mapParam);
    }


    /**
     * 수입면허 품목선정 POP-UP item 가입고  목록을 조회한다.
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
    public RecordSet selectItemInfoSaveReceiveSearchPop2(Map<String, Object> mapParam) throws Exception {
        return entryMstDAO.selectItemInfoSaveReceiveSearchPop2(mapParam);
    }

    /**
     * 통관 마스터을 조회한다.
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
    public RecordSet selectEntryMst(Map<String, Object> mapParam) throws Exception {
        return entryMstDAO.selectEntryMst(mapParam);
    }

    /**
     * 통관 마스터을 조회한다.
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
    public RecordSet searchSignExchangeRate(Map<String, Object> mapParam) throws Exception {
        return entryMstDAO.searchSignExchangeRate(mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveEntryDtl(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsEntryMst
            , DataSetMap dsEntryItemDetailList
            ) throws Exception  {
        int entryMstProcCnt = 0;
        int entryItemDetailProcCnt = 0;
        int entryEndQuantityProcCnt = 0;
        String entryNum = "";	//통관 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();

        //1.통관 마스터 저장
        if ( dsEntryMst.size() > 0 )
        {
            for (int i = 0 ; i < dsEntryMst.size() ; i++) {
                Map<String, Object> parameter = dsEntryMst.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    entryNum = entryMstDAO.getEntryNumSeq(parameter);	//통관 번호 - IMCL-YYMM-SEQ(4)
                    logger.info( "entryNum2  ::::"+entryNum  );
                    String currYymm = LimsUtil.getDate("yyMM");
                    entryNum = "IMCL"+currYymm+entryNum;
                    parameter.put("entryNum", entryNum);
                    entryMstProcCnt += entryMstDAO.insert(parameter);
                } else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    entryMstProcCnt += entryMstDAO.update(parameter);
                    entryNum = parameter.get("entryNum").toString();
                }
            }
        }

        logger.info( "entryNum3  ::::"+entryNum  );

        //2.통관 품목 상세 저장
        if ( dsEntryItemDetailList.size() > 0 ) {
            for (int i = 0 ; i < dsEntryItemDetailList.size() ; i++) {
                Map<String, Object> parameter = dsEntryItemDetailList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                
                logger.info( "entryReqWonwtrAmt  ::::"+parameter.get("entryReqWonwtrAmt").toString()  );
                
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( !"".equals(entryNum) )
                    {
                        parameter.put("entryNum", entryNum);
                    }
                    entryNum = parameter.get("entryNum").toString();
                    entryItemDetailProcCnt += entryItemDetailDAO.insert(parameter);
                    parameter.put("flag", "I");
                    logger.info( "flag:I" );
                    entryEndQuantityProcCnt += poOrderItemDetailDAO.updateEntryEndQuantity(parameter);
                    entryEndQuantityProcCnt +=whbyItembyChargAmtDAO.mergeGvrntaxRate(parameter);	//창고 품목별 관세율 관리 insert,update
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    entryItemDetailProcCnt += entryItemDetailDAO.update(parameter);
                    parameter.put("flag", "U");
                    logger.info( "flag:U" );
                    entryEndQuantityProcCnt += poOrderItemDetailDAO.updateEntryEndQuantity(parameter);
                    entryNum = parameter.get("entryNum").toString();
                    entryEndQuantityProcCnt +=whbyItembyChargAmtDAO.mergeGvrntaxRate(parameter);	//창고 품목별 관세율 관리 insert,update
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    entryItemDetailProcCnt += entryItemDetailDAO.delete(parameter);
                    parameter.put("flag", "D");
                    logger.info( "flag:D" );
                    entryEndQuantityProcCnt += poOrderItemDetailDAO.updateEntryEndQuantity(parameter);
                    entryNum = parameter.get("entryNum").toString();
                }


            }
        }

        logger.info("LAST entryNum :"+entryNum);
        map.put("entryNum", entryNum);	//통관번호 전달
        map.put("procCnt", entryMstProcCnt+entryItemDetailProcCnt+entryEndQuantityProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 전체 Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @Override
    @SuppressWarnings("unchecked")
    public int deleteEntryList(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsList
            ) throws Exception  {

        int delRowCnt = 0;
        Map<String, Object> setMap = new HashMap<String, Object>();

        for (int i = 0 ; i < dsList.size() ; i++) {
            Map<String, Object> rowData = dsList.get(i);
            //1.통관 삭제시 구매 주문 품목 상세의 차감시킬 통관완료수량을 조회 후 통관완료수량 -UPDATE
            RecordSet quantityrRs = entryItemDetailDAO.selectEntryReqQuantity(rowData);
            for ( int quantityrRow=0; quantityrRow<quantityrRs.size(); quantityrRow++ )
            {
                Map<String, Object> quantityrRc = quantityrRs.get(quantityrRow);
                setMap.put("flag", "D");
                setMap.put("entryReqQuantity", quantityrRc.get("entryReqQuantity"));
                setMap.put("entryReqWgt", quantityrRc.get("entryReqWgt"));
                setMap.put("poOrderNum", quantityrRc.get("poOrderNum"));
                setMap.put("itemSeq", quantityrRc.get("itemSeq"));
                delRowCnt += poOrderItemDetailDAO.updateEntryEndQuantity(setMap);
            }
            //2.통관 마스터 삭제
            delRowCnt += entryMstDAO.delete(rowData);
            //3.통관 품목 상세 삭제
            delRowCnt += entryItemDetailDAO.deleteAll(rowData);
        }

        return delRowCnt;
    }


    /**
     * 가입고 품목선정 POP-UP 목록 목록을 조회한다.
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
    public RecordSet selectBlListPop(Map<String, Object> mapParam) throws Exception {
        return entryMstDAO.selectBlListPop(mapParam);
    }


    /**
     * 가입고 품목선정 POP-UP item 목록을 조회한다.
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
    public RecordSet selectBlListPop2(Map<String, Object> mapParam) throws Exception {
        return entryMstDAO.selectBlListPop2(mapParam);
    }

    /**
     * 면허번호 중복체크
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
    public String dupIncomeLicNumYn(Map<String, Object> mapParam) throws Exception {
        return entryMstDAO.dupIncomeLicNumYn(mapParam);
    }
}
