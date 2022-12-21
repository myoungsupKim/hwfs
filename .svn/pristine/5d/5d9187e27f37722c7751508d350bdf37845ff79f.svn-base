package com.hwfs.ft.ftr.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.ftr.dao.FtStatsDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 식재도매 통계조회 ServiceImple Class
 *
 * @ClassName FtStatsServiceImpl.java
 * @Description FtStatsServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 06.   kkj         최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kkh
 * @since 2015. 7. 06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/ftr/ftStatsService")
public class FtStatsServiceImpl extends DefaultServiceImpl implements FtStatsService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    @Resource(name = "/ft/ftr/ftStatsDAO")
    private FtStatsDAO ftStatsDAO;

    /**
     * PO별 재고 금액을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#pobyInventoryAmt(java.util.Map)
    */
    @Override
    public RecordSet pobyInventoryAmt(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.pobyInventoryAmt(parameter);
    }

    /**
     * PO별 재고 이력을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#pobyInventoryLog(java.util.Map)
    */
    @Override
    public RecordSet pobyInventoryLog(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.pobyInventoryLog(parameter);
    }

    /**
     * 출고내역을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#releaseDescInquery(java.util.Map)
    */
    @Override
    public RecordSet releaseDescInquery(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.releaseDescInquery(parameter);
    }

    /**
     * 창고/품목별 재고현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#whItemInquery(java.util.Map)
    */
    @Override
    public RecordSet whItemInquery(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.whItemInquery(parameter);
    }

    /**
     * 품목/창고별 재고현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#itemWhInquery(java.util.Map)
    */
    @Override
    public RecordSet itemWhInquery(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.itemWhInquery(parameter);
    }

    /**
     * 영업사원별 매출현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#poSalsStatus(java.util.Map)
    */
    @Override
    public RecordSet poSalsStatus(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.poSalsStatus(parameter);
    }

    /**
     * PO별 기타선급금 미착 금액 상세
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#pobyPrepayamtNonarrivAmtDetail(java.util.Map)
    */
    @Override
    public RecordSet pobyPrepayamtNonarrivAmtDetail(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.pobyPrepayamtNonarrivAmtDetail(parameter);
    }

    /**
     * 일별 재고 부진재고 상세
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#ddbyInventoryPoorInventoryDet(java.util.Map)
    */
    @Override
    public RecordSet ddbyInventoryPoorInventoryDet(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.ddbyInventoryPoorInventoryDet(parameter);
    }

    /**
     * 월별 PO별 판매완료
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#mmbyPobySalend(java.util.Map)
    */
    @Override
    public RecordSet mmbyPobySalend(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.mmbyPobySalend(parameter);
    }

    /**
     * 입고 PO 품목별 원가/판가 상세 - 수입
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#mmbyPobySalend(java.util.Map)
    */
    @Override
    public RecordSet deliverPoItembyDetailIncome(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.deliverPoItembyDetailIncome(parameter);
    }

    /**
     * 입고 PO 품목별 원가/판가 상세 - 판매
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#mmbyPobySalend(java.util.Map)
    */
    @Override
    public RecordSet deliverPoItembyDetailDmt(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.deliverPoItembyDetailDmt(parameter);
    }

    /**
     * PO별 내수 매입 금액
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#pobyDmtBuyAmt(java.util.Map)
    */
    @Override
    public RecordSet pobyDmtBuyAmt(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.pobyDmtBuyAmt(parameter);
    }

    /**
     * PO별 수입 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#pobyIncomeStatusRpt(java.util.Map)
    */
    @Override
    public RecordSet pobyIncomeStatusRpt(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.pobyIncomeStatusRpt(parameter);
    }
    
    /**
     * PO별 수입 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#pobyIncomeStatusRpt(java.util.Map)
    */
    @Override
    public RecordSet pobyIncomeStatusRpt2(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.pobyIncomeStatusRpt2(parameter);
    }    

    /**
     * 월별 예상 창고 보관료
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#expectWhChargamtRpt(java.util.Map)
    */
    @Override
    public RecordSet expectWhChargamtRpt(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.expectWhChargamtRpt(parameter);
    }

    /**
     * 주차 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#pobyIncomeStatusRpt(java.util.Map)
    */
    @Override
    public RecordSet selectWeekYearMm(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.selectWeekYearMm(parameter);
    }

    /**
     * 주차에 대해 이번주차외 이전 5개 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#pobyIncomeStatusRpt(java.util.Map)
    */
    @Override
    public RecordSet selectWeekOfYearMm(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.selectWeekOfYearMm(parameter);
    }

    /**
     * 품목별 시세 관리 리포트
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#expectWhChargamtRpt(java.util.Map)
    */
    @Override
    public RecordSet itembyPriceMgmtRpt(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.itembyPriceMgmtRpt(parameter);
    }

    /**
     * 주차에 대해 시세를 저장
     *
     * @param param
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#saveWeekYearMm(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveWeekYearMm(Map<String, Object> param, DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                parameter.put("yy", LimsUtil.checkNull(param.get("yy")));
                parameter.put("mm", LimsUtil.checkNull(param.get("mm")));
                parameter.put("weekOfYear", LimsUtil.checkNull(param.get("weekOfYear")));
                procCnt += ftStatsDAO.saveWeekYearMm(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 부진재고 상세 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#expectWhChargamtRpt(java.util.Map)
    */
    @Override
    public RecordSet poorInventoryDet(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.poorInventoryDet(parameter);
    }

    /**
     * 영업사원 계획 등록(사업계획)을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#salesmanPlanRegList(java.util.Map)
    */
    @Override
    public RecordSet salesmanPlanRegList(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.salesmanPlanRegList(parameter);
    }

    /**
     * 영업사원 계획 등록(수정계획)을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#salesmanPlanRegList2(java.util.Map)
    */
    @Override
    public RecordSet salesmanPlanRegList2(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.salesmanPlanRegList2(parameter);
    }

    /**
     * 영업사원 계획 등록(사업계획,수정계획)을 등록
     *
     * @param param
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#saveWeekYearMm(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @SuppressWarnings("unchecked")
    public Map<String, Object> salesmanPlanReg(Map<String, Object> param, DataSetMap saveList, DataSetMap saveList2) throws Exception {
        logger.info( "#########salesmanPlanReg##########");
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        //1.사업계획 등록
        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_INSERTED) {
                for ( int j=1; j<=12; j++)
                {
                    parameter.put("year", LimsUtil.checkNull(param.get("year")));	//년도
                    parameter.put("mm", j);											//월
                    parameter.put("planClass", "A");								//계획구분 A:사업계획 B:수정계획
                    parameter.put("sals", Integer.parseInt(LimsUtil.checkNull(parameter.get("sals"+j),"0")));
                    parameter.put("salsGain", Integer.parseInt(LimsUtil.checkNull(parameter.get("salsGain"+j),"0")));
                    procCnt += ftStatsDAO.salesmanPlanReg(parameter);
                }
            }
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                for ( int j=1; j<=12; j++)
                {
                    parameter.put("year", LimsUtil.checkNull(param.get("year")));	//년도
                    parameter.put("mm", j);											//월
                    parameter.put("planClass", "A");								//계획구분 A:사업계획 B:수정계획
                    procCnt += ftStatsDAO.deleteSalesmanPlanReg(parameter);
                }
            }
        }
        logger.info( "saveList2.size() :"+saveList2.size());
        //2.수정계획 등록
        for (int i = 0; i < saveList2.size(); i++) {
            parameter = saveList2.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            logger.info( "year1 :"+LimsUtil.checkNull(param.get("year")));
            if (rowType == DataSet.ROW_TYPE_UPDATED || rowType == DataSet.ROW_TYPE_INSERTED) {
                for ( int j=1; j<=12; j++)
                {
                    parameter.put("year", LimsUtil.checkNull(param.get("year")));	//년도
                    parameter.put("mm", j);											//월
                    parameter.put("planClass", "B");								//계획구분 A:사업계획 B:수정계획
                    parameter.put("sals", Integer.parseInt(LimsUtil.checkNull(parameter.get("sals"+j),"0")));
                    parameter.put("salsGain", Integer.parseInt(LimsUtil.checkNull(parameter.get("salsGain"+j),"0")));
                    procCnt += ftStatsDAO.salesmanPlanReg(parameter);
                }
            }
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                for ( int j=1; j<=12; j++)
                {
                    parameter.put("year", LimsUtil.checkNull(param.get("year")));	//년도
                    parameter.put("mm", j);											//월
                    parameter.put("planClass", "B");								//계획구분 A:사업계획 B:수정계획
                    procCnt += ftStatsDAO.deleteSalesmanPlanReg(parameter);
                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 영업사원 계획 실적 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#salesmanPlanRegList(java.util.Map)
    */
    @Override
    public RecordSet salesmanPlanRegAct(Map<String, Object> parameter) throws Exception {
        RecordSet rs = ftStatsDAO.salesmanPlanRegAct(parameter);
        for ( int i=0; i<rs.size(); i++)
        {
            Record rd =  rs.get(i);

//            rd.set("lvl", rd.getDouble("lvl") +"");
            if ( "1".equals(rd.getString("flag")) )	  //매출
            {
                for ( int j=0; j<=12; j++)
                {
                    LimsUtil.getCommaNumber(100000.23, "###,###,###,##0");

                    rd.set("sa"+j+"Sals", LimsUtil.getCommaNumber(rd.getDouble("sa"+j+"Sals"), "###,###,###,##0") +"");
                    rd.set("su"+j+"Sals", LimsUtil.getCommaNumber(rd.getDouble("su"+j+"Sals"), "###,###,###,##0")+"");
                    rd.set("prevRealSaleAmt"+j, LimsUtil.getCommaNumber(rd.getDouble("prevRealSaleAmt"+j), "###,###,###,##0")+"");
                    rd.set("prevRealSaleAmt"+j+"Rate", LimsUtil.getCommaNumber(rd.getDouble("prevRealSaleAmt"+j+"Rate"), "###,###,###,##0")+"%");

                    rd.set("realSaleAmt"+j, LimsUtil.getCommaNumber(rd.getDouble("realSaleAmt"+j), "###,###,###,##0")+"");

                    rd.set("saSals"+j+"Rate", LimsUtil.getCommaNumber(rd.getDouble("saSals"+j+"Rate"), "###,###,###,##0")+"%");
                    rd.set("suSals"+j+"Rate", LimsUtil.getCommaNumber(rd.getDouble("suSals"+j+"Rate"), "###,###,###,##0")+"%");
                }
            }

            if ( "2".equals(rd.getString("flag")) )	  //매출이익
            {
                for ( int j=0; j<=12; j++)
                {
                    rd.set("sa"+j+"Sals", LimsUtil.getCommaNumber(rd.getDouble("sa"+j+"Sals"), "###,###,###,##0")+"");
                    rd.set("su"+j+"Sals", LimsUtil.getCommaNumber(rd.getDouble("su"+j+"Sals"), "###,###,###,##0")+"");
                    rd.set("prevRealSaleAmt"+j, LimsUtil.getCommaNumber(rd.getDouble("prevRealSaleAmt"+j), "###,###,###,##0")+"");
                    rd.set("realSaleAmt"+j, LimsUtil.getCommaNumber(rd.getDouble("realSaleAmt"+j), "###,###,###,##0")+"");

                    if ( rd.getDouble("saSals"+j+"Rate") >= 0  )
                    {
                        if ( rd.getDouble("saSals"+j+"Rate") == 0  ) {
                            rd.set("saSals"+j+"Rate", "0");		//사업계획비
                        } else {
                            rd.set("saSals"+j+"Rate", "+"+LimsUtil.getCommaNumber(rd.getDouble("saSals"+j+"Rate"), "###,###,###,##0")+"");
                        }
                    }
                    else
                    {
                        rd.set("saSals"+j+"Rate", "△"+LimsUtil.getCommaNumber(Math.abs(rd.getDouble("saSals"+j+"Rate")), "###,###,###,##0")+"");
                    }

                    if ( rd.getDouble("suSals"+j+"Rate") >= 0  )	//수정계획비
                    {
                        if ( rd.getDouble("suSals"+j+"Rate") == 0  ) {
                            rd.set("suSals"+j+"Rate", "0");		//사업계획비
                        } else {
                            rd.set("suSals"+j+"Rate", "+"+LimsUtil.getCommaNumber(Math.abs(rd.getDouble("suSals"+j+"Rate")), "###,###,###,##0"));
                        }
                    }
                    else
                    {
                        rd.set("suSals"+j+"Rate", "△"+LimsUtil.getCommaNumber(Math.abs(rd.getDouble("suSals"+j+"Rate")), "###,###,###,##0"));
                    }

                    if ( rd.getDouble("prevRealSaleAmt"+j+"Rate") >= 0  )	//수정계획비
                    {
                        if ( rd.getDouble("prevRealSaleAmt"+j+"Rate") == 0  ) {
                            rd.set("prevRealSaleAmt"+j+"Rate", 0);
                        } else {
                            rd.set("prevRealSaleAmt"+j+"Rate", "+"+LimsUtil.getCommaNumber(Math.abs(rd.getDouble("prevRealSaleAmt"+j+"Rate")), "###,###,###,##0"));
                        }
                    }
                    else
                    {
                        rd.set("prevRealSaleAmt"+j+"Rate", "△"+LimsUtil.getCommaNumber(Math.abs(rd.getDouble("prevRealSaleAmt"+j+"Rate")), "###,###,###,##0"));
                    }
                }
            }

            if ( "3".equals(rd.getString("flag")) )	  //매출이익률
            {
                for ( int j=0; j<=12; j++)
                {
                    rd.set("sa"+j+"Sals", LimsUtil.getCommaNumber(rd.getDouble("sa"+j+"Sals"), "###,###,###,##0.#")+"%");
                    rd.set("su"+j+"Sals", LimsUtil.getCommaNumber(rd.getDouble("su"+j+"Sals"), "###,###,###,##0.#")+"%");
                    rd.set("prevRealSaleAmt"+j, LimsUtil.getCommaNumber(rd.getDouble("prevRealSaleAmt"+j), "###,###,###,##0.#")+"%");
                    rd.set("realSaleAmt"+j, LimsUtil.getCommaNumber(rd.getDouble("realSaleAmt"+j), "###,###,###,##0.#")+"%");

                    if ( rd.getDouble("saSals"+j+"Rate") >= 0  )
                    {
                        if ( rd.getDouble("saSals"+j+"Rate") == 0  ) {
                            rd.set("saSals"+j+"Rate", "0%p");		//사업계획비
                        } else {
                            rd.set("saSals"+j+"Rate", "↓"+LimsUtil.getCommaNumber(rd.getDouble("saSals"+j+"Rate"), "###,###,###,##0.#")+"%p");
                        }
                    }
                    else
                    {
                        rd.set("saSals"+j+"Rate", "↑"+LimsUtil.getCommaNumber(Math.abs(rd.getDouble("saSals"+j+"Rate")), "###,###,###,##0.#")+"%p");
                    }

                    if ( rd.getDouble("suSals"+j+"Rate") >= 0  )	//수정계획비
                    {
                        if ( rd.getDouble("suSals"+j+"Rate") == 0  ) {
                            rd.set("suSals"+j+"Rate", "0%p");
                        } else {
                            rd.set("suSals"+j+"Rate", "↓"+LimsUtil.getCommaNumber(rd.getDouble("suSals"+j+"Rate"), "###,###,###,##0.#")+"%p");
                        }
                    }
                    else
                    {
                        rd.set("suSals"+j+"Rate", "↑"+LimsUtil.getCommaNumber(Math.abs(rd.getDouble("suSals"+j+"Rate")), "###,###,###,##0.#")+"%p");
                    }

                    if ( rd.getDouble("prevRealSaleAmt"+j+"Rate") >= 0  )	//수정계획비
                    {
                        if ( rd.getDouble("prevRealSaleAmt"+j+"Rate") == 0  ) {
                            rd.set("prevRealSaleAmt"+j+"Rate",  "0%p");
                        } else {
                            rd.set("prevRealSaleAmt"+j+"Rate", "↓"+LimsUtil.getCommaNumber(rd.getDouble("prevRealSaleAmt"+j+"Rate"), "###,###,###,##0.#")+"%p");
                        }
                    }
                    else
                    {
                        rd.set("prevRealSaleAmt"+j+"Rate", "↑"+LimsUtil.getCommaNumber(Math.abs(rd.getDouble("prevRealSaleAmt"+j+"Rate")), "###,###,###,##0.#")+"%p");
                    }

                    //rd.set("saSals"+j, LimsUtil.checkNull(rd.getBigDecimal("saSals"+j), "0") + "%");
                    //System.out.println(rd.get("saSals"+j));
                }
//                rd.set("sa1Sals", rd.getString("sa1Sals") +"1%");
            }

        }
        return rs;
    }


    /**
     * SAP 전표 전송 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#salesmanPlanRegList2(java.util.Map)
    */
    @Override
    public RecordSet sapSlipSendStatus(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.sapSlipSendStatus(parameter);
    }

    /**
     * SAP 전표 전송 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#salesmanPlanRegList2(java.util.Map)
    */
    @Override
    public RecordSet sapSlipSendStatusDtlList(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.sapSlipSendStatusDtlList(parameter);
    }


    /**
     * PO별 미착 재고 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#whItemInquery(java.util.Map)
    */
    @Override
    public RecordSet pobyNonarrivInventoryStatus(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.pobyNonarrivInventoryStatus(parameter);
    }
    /**
     * PO별 상품 재고 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.ftr.service.FtStatsService#whItemInquery(java.util.Map)
    */
    @Override
    public RecordSet pobyGoodsInventoryStatus(Map<String, Object> parameter) throws Exception {
        return ftStatsDAO.pobyGoodsInventoryStatus(parameter);
    }
}
