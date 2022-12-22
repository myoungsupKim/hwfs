package com.hwfs.ft.fts.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ft.fts.service.ReleaseMgmtService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.cmn.web.CreateFaxPdf;
import com.hwfs.sc.cmn.dto.FaxDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.FaxService;
import com.hwfs.sc.cmn.util.DateUtil;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

/**
* 판매 주문내역에 대하여 출고를 관리하는 ReleaseMgmt Controller
*
* @ClassName ReleaseMgmtController.java
* @Description ReleaseMgmtController Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.04.30    kjj        최초생성
* </pre>
* @author FC종합전산구축 :  식재도매 kjj
* @since 2015.04.30
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Controller
@RequestMapping("/ft/fts/releaseMgmt/")
public class ReleaseMgmtController extends DefaultController {
    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /** ReleaseMgmtService Bean 생성 */
    @Resource(name = "/ft/fts/releaseMgmtService")
    private ReleaseMgmtService releaseMgmtService;

    /** FaxService Bean 생성 */
    @Resource(name = "/sc/cmn/faxService")
    private FaxService faxService;

    /**
     * 판매 주문내역에 대하여 출고를 관리 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectList.xdo")
    public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //판매 주문내역에 대하여 출고를 관리 을(를) 조회한다.
        RecordSet rs = releaseMgmtService.selectList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("releaseRegList.xdo")
    public ModelAndView releaseRegList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //판매 주문내역에 대하여 출고를 관리 을(를) 조회한다.
        RecordSet rs = releaseMgmtService.releaseRegList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리(을)를 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("deleteReleaseReg.xdo")
    public ModelAndView deleteReleaseReg(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");
        logger.info("parameter.size() ::::" + parameter.size());
        //입고(재고)를 판매 주문에 대하여 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.deleteReleaseReg(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리(을)를 출력 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("printReleaseReg.xdo")
    public ModelAndView printReleaseReg(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");
        logger.info("parameter.size() ::::" + parameter.size());
        //입고(재고)를 판매 주문에 대하여 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.printReleaseReg(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리(을)를 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveList2.xdo")
    public ModelAndView saveList2(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.saveList(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리(을)를 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveReleaseReg.xdo")
    public ModelAndView saveReleaseReg(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.saveReleaseReg(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고승인요청 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseApprovReq.xdo")
    public ModelAndView releaseApprovReq(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        List<String> al = new ArrayList<String>();
        for (int i = 0; i < param.get("ds_list").size(); i++) {
            logger.info("chk ::" + param.get("ds_list").get(i).get("chk"));
            if ("1".equals(param.get("ds_list").get(i).get("chk"))) {
                al.add(param.get("ds_list").get(i).get("releaseNum").toString());
                logger.info("releaseNum ::" + param.get("ds_list").get(i).get("releaseNum").toString());
            }
        }
        logger.info("al::::" + al);
        param.get("ds_search").get(0).put("releaseNums", al);

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.releaseApprovReq(parameter, param.get("ds_search").get(0));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @RequestMapping("selectReleaseMgmtList.xdo")
    public ModelAndView selectReleaseMgmtList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rs = releaseMgmtService.selectReleaseItemMgmtList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs); //출고리스트

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @RequestMapping("selectReleaseItemMgmtList.xdo")
    public ModelAndView selectReleaseItemMgmtList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //창고, 품목별로 보관료. 상세을(를) 조회한다.
        RecordSet rs = releaseMgmtService.selectReleaseItemMgmtList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs); //창고리스트

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 판매 주문내역에 대하여 출고등록취소 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseRollCancel.xdo")
    public ModelAndView releaseRollCancel(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.releaseRollCancel(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 거래명세서 출력 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("printDealReqDocPublish.xdo")
    public ModelAndView printDealReqDocPublish(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");
        DataSetMap dsSearch = param.get("ds_search");

        int processCnt = 0;
        logger.info("srcPrintChk ::"+dsSearch.get(0).get("srcPrintChk"));
        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        if ("1".equals(LimsUtil.checkNull(dsSearch.get(0).get("srcPrintChk")))) //조회출력
        {
            processCnt = releaseMgmtService.printDealReqDocPublish(dsSearch);
        } else {
            processCnt = releaseMgmtService.printDealReqDocPublishChk(parameter);
        }
        logger.info("processCnt::::" + processCnt);
        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고승인요청취소 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseApprovReqCancel.xdo")
    public ModelAndView releaseApprovReqCancel(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.releaseApprovReqCancel(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고승인 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseApprov.xdo")
    public ModelAndView releaseApprov(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        List<String> al = new ArrayList<String>();
        for (int i = 0; i < param.get("ds_list").size(); i++) {
            logger.info("chk ::" + param.get("ds_list").get(i).get("chk"));
            if ("1".equals(param.get("ds_list").get(i).get("chk"))) {
                al.add(param.get("ds_list").get(i).get("releaseNum").toString());
                logger.info("releaseNum ::" + param.get("ds_list").get(i).get("releaseNum").toString());
            }
        }
        logger.info("al::::" + al);
        param.get("ds_search").get(0).put("releaseNums", al);

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.releaseApprov(parameter, param.get("ds_search").get(0));

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 팀장승인취소 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseApprovCancel.xdo")
    public ModelAndView releaseApprovCancel(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.releaseApprovCancel(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고확정 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseConfirm.xdo")
    public ModelAndView releaseConfirm(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();
        LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");
        DataSetMap dsSearch = param.get("ds_search");

        //        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        //        List<Map<String, Object>> listMap = releaseMgmtService.releaseBuyCostExcept(dsSearch, parameter, loginDTO);

        List<String> al = new ArrayList<String>();
        for (int i = 0; i < param.get("ds_list").size(); i++) {
            logger.info("chk ::" + param.get("ds_list").get(i).get("chk"));
            if ("1".equals(param.get("ds_list").get(i).get("chk"))) {
                al.add(param.get("ds_list").get(i).get("releaseNum").toString());
                logger.info("releaseNum ::" + param.get("ds_list").get(i).get("releaseNum").toString());
            }
        }
        logger.info("al::::" + al);
        param.get("ds_search").get(0).put("releaseNums", al);

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.releaseConfirm(dsSearch, parameter, loginDTO);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고확정 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseConfirmCancel.xdo")
    public ModelAndView releaseConfirmCancel(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.releaseConfirmCancel(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 환입 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releasePurchaseReturn.xdo")
    public ModelAndView releasePurchaseReturn(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.releasePurchaseReturn(parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 중량변경,환입 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_search");
        DataSetMap parameter2 = param.get("ds_list");
        int processCnt = 0;

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        logger.info("fvIProcessFlag :::" + parameter.get(0).get("fvIProcessFlag"));
        if ("RTN".equals(parameter.get(0).get("fvIProcessFlag"))) //환입
        {
            processCnt = releaseMgmtService.releasePurchaseReturn(parameter2);
        } else if ("WHG".equals(parameter.get(0).get("fvIProcessFlag"))) //중량변경
        {
            processCnt = releaseMgmtService.releaseWhgChg(parameter2);
        } else if ("UPRICE".equals(parameter.get(0).get("fvIProcessFlag"))) //단가변경
        {
            processCnt = releaseMgmtService.releaseUpriceChg(parameter2);
        }

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 단가변경 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("upriceChg.xdo")
    public ModelAndView upriceChg(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter2 = param.get("ds_list");
        int processCnt = releaseMgmtService.releaseUpriceChg(parameter2);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 중량변경 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseWhgChg.xdo")
    public ModelAndView releaseWhgChg(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter2 = param.get("ds_list");
        int processCnt = releaseMgmtService.releaseWhgChg(parameter2);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고증 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @RequestMapping("selectReleaseReqCertificatePrintPop.xdo")
    public ModelAndView selectReleaseReqCertificatePrintPop(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //판매 주문내역에 대하여 출고를 관리 을(를) 조회한다.
        RecordSet rs = releaseMgmtService.selectReleaseReqCertificatePrintPop(parameter.get("ds_search").get(0));
        RecordSet rs2 = releaseMgmtService.selectReleaseReqCertificatePrintPop2(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);
        super.addOutDataSet(mav, "ds_list2", rs2);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고증 발행 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("printReleaseReqCertificate.xdo")
    public ModelAndView printReleaseReqCertificate(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");
        DataSetMap dsSearch = param.get("ds_search");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = releaseMgmtService.printReleaseReqCertificate(dsSearch, parameter);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고확정 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @RequestMapping("selectSalsConfirmList.xdo")
    public ModelAndView selectSalsConfirmList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
            throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //판매 주문내역에 대하여 출고를 관리 을(를) 조회한다.
        RecordSet rs = releaseMgmtService.selectSalsConfirmList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rs);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 출고확정를 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveSalsConfirmList.xdo")
    public ModelAndView saveSalsConfirmList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap parameter = param.get("ds_list");
        DataSetMap dsSearch = param.get("ds_search");
        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        //        param.put("loginSabun", loginDTO.getSabun());

        int processCnt = releaseMgmtService.saveSalsConfirmList(parameter, loginDTO, dsSearch);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 매입원가 차감 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseBuyCostExcept.xdo")
    public ModelAndView releaseBuyCostExcept(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();
        LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap dsSearch = param.get("ds_search");
        DataSetMap parameter = param.get("ds_list");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        List<Map<String, Object>> listMap = releaseMgmtService.releaseBuyCostExcept(dsSearch, parameter, loginDTO);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        logger.info("procCnt :" + listMap.get(0).get("procCnt"));
        logger.info("slipNums :" + listMap.get(0).get("slipNums"));
        ArrayList slipNums = (ArrayList) listMap.get(0).get("slipNums");

        String sSlipNums = "";
        for (int i = 0; i < slipNums.size(); i++) {
            sSlipNums += slipNums.get(i).toString() + ",";
        }
        sSlipNums = sSlipNums.substring(0, sSlipNums.length() - 1);
        logger.info("sSlipNums :" + sSlipNums);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_slipNums", sSlipNums);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 원가대체 회계전표 IF 취소 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("releaseBuyCostExceptCancel.xdo")
    public ModelAndView releaseBuyCostExceptCancel(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        int procCnt = releaseMgmtService.releaseBuyCostExceptCancel(loginDTO, parameter.get("ds_search"),
                parameter.get("ds_list"));

        logger.info("procCnt :" + procCnt);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 판매 주문내역에 대하여 매입원가 차감 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
     * </pre>
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("releaseBuyCostInc.xdo")
    public ModelAndView releaseBuyCostInc(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();
        LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
        DataSetMap dsSearch = param.get("ds_search");
        DataSetMap parameter = param.get("ds_list");

        //판매 주문내역에 대하여 출고를 관리을(를) 등록, 수정, 삭제 처리한다.
        List<Map<String, Object>> listMap = releaseMgmtService.releaseBuyCostExcept(dsSearch, parameter, loginDTO);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        logger.info("procCnt :" + listMap.get(0).get("procCnt"));
        logger.info("slipNums :" + listMap.get(0).get("slipNums"));
        ArrayList slipNums = (ArrayList) listMap.get(0).get("slipNums");

        String sSlipNums = "";
        for (int i = 0; i < slipNums.size(); i++) {
            sSlipNums += slipNums.get(i).toString() + ",";
        }
        sSlipNums = sSlipNums.substring(0, sSlipNums.length() - 1);
        logger.info("sSlipNums :" + sSlipNums);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_slipNums", sSlipNums);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 수수료 회계전표 IF 버튼 클릭시 SAP
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("saveBuyCostExceptDraft.xdo")
    public ModelAndView saveBuyCostExceptDraft(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
            HttpServletRequest request) throws Exception {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap = releaseMgmtService.saveBuyCostExceptDraft(parameter.get("ds_search"),
                parameter.get("ds_list"), loginDTO);

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        logger.info("procCnt :" + listMap.get(0).get("procCnt"));
        logger.info("slipNums :" + listMap.get(0).get("slipNums"));
        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_poOrderNum", listMap.get(0).get("poOrderNum"));
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");

    }

    /**
     * 여신체크
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("getLendingChk.xdo")
    public ModelAndView getLendingChk(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDto, HttpServletRequest req)
            throws Exception {
        ModelAndView mav = super.createModelAndView();
        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();

        List<String> al = new ArrayList<String>();
        for (int i = 0; i < parameter.get("ds_list").size(); i++) {
            logger.info("chk ::" + parameter.get("ds_list").get(i).get("chk"));
            if ("1".equals(parameter.get("ds_list").get(i).get("chk"))) {
                al.add(parameter.get("ds_list").get(i).get("releaseNum").toString());
                logger.info("releaseNum ::" + parameter.get("ds_list").get(i).get("releaseNum").toString());
            }

        }

        parameter.get("ds_search").get(0).put("releaseNums", al);

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        RecordSet rs = releaseMgmtService.getLendingChk(parameter.get("ds_search").get(0)); //여신조회
        Record rd = releaseMgmtService.getLendingChk2(parameter.get("ds_search").get(0)); //여신조회:출고요청,출고승인,확정금액
        logger.info("preAmt1 :" + rs.get(0).get("preAmt1").toString());
        logger.info("preAmt2 :" + rs.get(0).get("preAmt2").toString());

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        String creditAmount = ""; //여신금액
        String rmnAmt = ""; //외상매출잔액
        String preAmt = ""; //선수잔액
        String preAmt1 = ""; //선수잔액
        String preAmt2 = ""; //선수잔액
        String creditOverAmount = ""; //임시여신
        if (rs != null) {
            creditAmount = rs.get(0).get("creditAmount").toString(); //여신금액
            rmnAmt = rs.get(0).get("rmnAmt").toString(); //외상매출잔액
            preAmt = rs.get(0).get("preAmt").toString(); //선수잔액
            preAmt1 = rs.get(0).get("preAmt1").toString(); //계약이행예치금
            preAmt2 = rs.get(0).get("preAmt2").toString(); //선수잔액
            creditOverAmount = rs.get(0).get("creditOverAmount").toString(); //임시여신
        }

        String releaseAmt = ""; //출고요청금액
        String reqAmt = ""; //승인요청금액
        String approvAmt = ""; //팀장승인금액
        String confirmAmt = ""; //확정금액
        if (rd != null) {
            releaseAmt = rd.getString("releaseAmt");
            reqAmt = rd.getString("reqAmt");
            approvAmt = rd.getString("approvAmt");
            confirmAmt = rd.getString("confirmAmt");
        }

        logger.info("creditAmount :" + creditAmount);
        logger.info("rmnAmt :" + rmnAmt);
        logger.info("preAmt :" + preAmt);
        logger.info("reqAmt :" + reqAmt);

        super.addOutVariable(mav, "fv_creditAmount", creditAmount);
        super.addOutVariable(mav, "fv_rmnAmt", rmnAmt);
        super.addOutVariable(mav, "fv_preAmt", preAmt);
        super.addOutVariable(mav, "fv_preAmt1", preAmt1);
        super.addOutVariable(mav, "fv_preAmt2", preAmt2);
        super.addOutVariable(mav, "fv_creditOverAmount", creditOverAmount);

        super.addOutVariable(mav, "fv_reqAmt", reqAmt);
        super.addOutVariable(mav, "fv_releaseAmt", releaseAmt);
        super.addOutVariable(mav, "fv_approvAmt", approvAmt);
        super.addOutVariable(mav, "fv_confirmAmt", confirmAmt);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 출고증 Fax 발송
     *
     * @param xpDTO
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("releaseFaxTransfer.xdo")
    public ModelAndView releaseFaxTransfer(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDto,
            HttpServletRequest request) throws Exception {
        ModelAndView mav = createModelAndView();

        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        logger.info("srcPrintChk :" + parameter.get("ds_search").get(0).get("srcPrintChk"));
        RecordSet rs = releaseMgmtService.releaseFaxTransfer(parameter.get("ds_search").get(0));

        // root 경로
        String realpath = propertiesService.getString("global.filerepository.path");

        // pdf파일이 생성될 경로
        String realFtPath = realpath + propertiesService.getString("ft.file.path") + File.separator;
        // folder가 없으면 생성
        LimsUtil.makeFolder(realFtPath);

        // css, html, font, 한화직인 경로
        realpath = realpath + propertiesService.getString("ls.file.path")
                + propertiesService.getString("ls.inspectrpt.upload.path") + File.separator;
        // folder가 없으면 생성
        LimsUtil.makeFolder(realpath);

        String strCss = realpath + "inspectRpt.css";
        String htmlFile = realpath + "releaseReqRpt.html";
        String transTitle = LimsUtil.checkNull(parameter.get("ds_search").get(0).get("releaseReqCert"));
        String faxNo = LimsUtil.checkNull(parameter.get("ds_search").get(0).get("faxNo"));

        String serverIP = request.getServerName();
        String serverPORT = String.valueOf(request.getServerPort());

        String linkPath = request.getScheme() + "://" + serverIP + ":" + serverPORT
                + propertiesService.getString("ls.img.sign.upload.linkpath");
        String linkPathHanwha = request.getScheme() + "://" + serverIP + ":" + serverPORT
                + propertiesService.getString("ls.inspectrpt.upload.linkpath");

        String tmpWhCd = "";
        List<Map<String, Object>> releaseList = new ArrayList<Map<String, Object>>();
        Map<String, Object> tmpRsd = new HashMap<String, Object>();
        Map<String, Object> rsd = new HashMap<String, Object>();
        int rowCnt = 0;
        int retVal = 0;

        if (!rs.isEmpty()) {
            //for (Map<String, Object> rsd : rs) {
            for (int i = 0; i < rs.size(); i++) {
                rsd = new HashMap<String, Object>();
                rsd = rs.get(i);
                if (!LimsUtil.checkNull(rsd.get("whCd")).equals(tmpWhCd)) {
                    if (rowCnt > 0) {
                        // pdf출력
                        retVal = prtFaxPds(realpath, realFtPath, linkPath, linkPathHanwha, strCss, htmlFile, transTitle,
                                releaseList, tmpRsd);
                        if (retVal < 0) {
                            return super.setResultSet(mav, DefaultConsts.ERR_CODE, "Fax발송 오류!");
                        }
                    }

                    releaseList = new ArrayList<Map<String, Object>>();
                    tmpRsd = new HashMap<String, Object>();
                    releaseList.add(rsd);
                    tmpRsd = rsd;
                    tmpRsd.put("faxNo", faxNo);
                    tmpWhCd = LimsUtil.checkNull(rsd.get("whCd"));
                } else {
                    releaseList.add(rsd);
                }
                rowCnt++;
            }
        }
        if (rowCnt > 0) {
            // pdf출력
            retVal = prtFaxPds(realpath, realFtPath, linkPath, linkPathHanwha, strCss, htmlFile, transTitle, releaseList, tmpRsd);
            if (retVal < 0) {
                return super.setResultSet(mav, DefaultConsts.ERR_CODE, "Fax발송 오류!");
            }
        }

        return setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * pdf출력 후 Fax발송
     *
     * @param realpath
     * @param realFtPath
     * @param linkPath
     * @param linkPathHanwha
     * @param strCss
     * @param htmlFile
     * @param transTitle
     * @param releaseList
     * @param tmpRsd
     * @return
     * @throws Exception
     */
    public int prtFaxPds(String realpath, String realFtPath, String linkPath, String linkPathHanwha, String strCss,
            String htmlFile, String transTitle, List<Map<String, Object>> releaseList, Map<String, Object> tmpRsd)
            throws Exception {

        int retVal = 0;
        // pdf 파일 경로 및 파일명 지정
        String createFile = realFtPath + LimsUtil.checkNull(tmpRsd.get("releaseNum")) + "_"
                + LimsUtil.checkNull(tmpRsd.get("whCd")) + "_" + DateUtil.getTimestamp() + ".pdf";

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("realpath", realpath);
        paramMap.put("linkPath", linkPath);
        paramMap.put("linkPathHanwha", linkPathHanwha);
        paramMap.put("createFile", createFile);
        paramMap.put("strCss", strCss);
        paramMap.put("htmlFile", htmlFile);
        paramMap.put("transTitle", transTitle);

        paramMap.put("whCd", LimsUtil.checkNull(tmpRsd.get("whCd")));
        paramMap.put("vdNmLoc", LimsUtil.checkNull(tmpRsd.get("vdNmLoc")));
        paramMap.put("releaseNum", LimsUtil.checkNull(tmpRsd.get("releaseNum")));
        paramMap.put("chamJo", "출고담당자");
        paramMap.put("sendInfo", LimsUtil.checkNull(tmpRsd.get("sendInfo")));
        paramMap.put("releaseDate", LimsUtil.checkNull(tmpRsd.get("releaseDate")));
        paramMap.put("custNm", LimsUtil.checkNull(tmpRsd.get("custNm")));
        paramMap.put("comLogo", LimsUtil.checkNull(tmpRsd.get("comLogo")));
        paramMap.put("faxNo", LimsUtil.checkNull(tmpRsd.get("faxNo")));

        paramMap.put("releaseList", releaseList);

        try {
            // pdf 파일 생성
            CreateFaxPdf.createFaxPdf(paramMap);

            // FAX 정보설정
            FaxDTO faxDTO = new FaxDTO();
            faxDTO.setRecipient("출고증발행-" + LimsUtil.checkNull(tmpRsd.get("releaseNum"))); // + "_" + LimsUtil.checkNull(tmpRsd.get("vdNmLocNm")));
            faxDTO.setFaxno(LimsUtil.checkNull(tmpRsd.get("faxNo")).replaceAll("[-]", ""));
            faxDTO.setFilename(createFile); // 생성된 pdf full path

            //등록된 사용자 설정
            faxDTO.setUserid(propertiesService.getString("fax.userid"));
            faxDTO.setUserpw(propertiesService.getString("fax.userpw"));

            //FAX 전송을(를) 등록 처리한다.
            retVal = faxService.send(faxDTO);
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage());
            retVal = -1;
        }

        return retVal;
    }

    /**
     * 여신조회
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectLendList.xdo")
    public ModelAndView selectLendList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDto, HttpServletRequest req)
            throws Exception {
        ModelAndView mav = super.createModelAndView();
        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        RecordSet rs = releaseMgmtService.selectLendList(parameter.get("ds_search").get(0)); //여신조회

        super.addOutDataSet(mav, "ds_list", rs);
        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 거래명세서 Fax 발송
     *
     * @param xpDTO
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("dealReqDocPublishFaxTransfer.xdo")
    public ModelAndView dealReqDocPublishFaxTransfer(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDto,
            HttpServletRequest request) throws Exception {
        ModelAndView mav = createModelAndView();

        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Record rs = releaseMgmtService.dealReqDocPublishCustFaxTransfer(parameter.get("ds_search").get(0));

        logger.info("srcPrintChk :" + LimsUtil.checkNull(parameter.get("ds_search").get(0).get("srcPrintChk")));
        RecordSet rs1 = null;
        if ("1".equals(LimsUtil.checkNull(parameter.get("ds_search").get(0).get("srcPrintChk")))) //조회출력
        {
            rs1 = releaseMgmtService.dealReqDocPublishListFaxTransferChk(parameter.get("ds_search").get(0));
        } else {
            rs1 = releaseMgmtService.dealReqDocPublishListFaxTransfer(parameter.get("ds_search").get(0));
        }

        // root 경로
        String realpath = propertiesService.getString("global.filerepository.path");

        // pdf파일이 생성될 경로
        String realFtPath = realpath + propertiesService.getString("ft.file.path") + File.separator;
        // folder가 없으면 생성
        LimsUtil.makeFolder(realFtPath);

        // css, html, font, 한화직인 경로
        realpath = realpath + propertiesService.getString("ls.file.path")
                + propertiesService.getString("ls.inspectrpt.upload.path") + File.separator;
        // folder가 없으면 생성
        LimsUtil.makeFolder(realpath);

        String strCss = realpath + "inspectRpt.css";
        String htmlFile = realpath + "dealReqDocPublish.html";

        String serverIP = request.getServerName();
        String serverPORT = String.valueOf(request.getServerPort());
        String linkPath = request.getScheme() + "://" + serverIP + ":" + serverPORT
                + propertiesService.getString("ls.img.sign.upload.linkpath");
        String linkPathHanwha = request.getScheme() + "://" + serverIP + ":" + serverPORT
                + propertiesService.getString("ls.inspectrpt.upload.linkpath");

        String salsplceCd = LimsUtil.checkNull(parameter.get("ds_search").get(0).get("salsplceCd"));
        String faxNo = LimsUtil.checkNull(parameter.get("ds_search").get(0).get("faxNo"));
        int retVal = 0;

        // pdf 파일 경로 및 파일명 지정
        String createFile = realFtPath + salsplceCd + "_" + DateUtil.getTimestamp() + ".pdf";

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("realpath", realpath);
        paramMap.put("createFile", createFile);
        paramMap.put("strCss", strCss);
        paramMap.put("htmlFile", htmlFile);
        paramMap.put("linkPath", linkPath);
        paramMap.put("linkPathHanwha", linkPathHanwha);

        paramMap.put("custInfo", rs);
        paramMap.put("releaseList", rs1);

        try {
            // pdf 파일 생성
            CreateFaxPdf.dealReqDocPublishCreateFaxPdf(paramMap);

            // FAX 정보설정
            FaxDTO faxDTO = new FaxDTO();
            faxDTO.setRecipient("거래명세서-" + salsplceCd);
            faxDTO.setFaxno(LimsUtil.checkNull(faxNo).replaceAll("[-]", ""));

            faxDTO.setFilename(createFile); // 생성된 pdf full path

            //등록된 사용자 설정
            faxDTO.setUserid(propertiesService.getString("fax.userid"));
            faxDTO.setUserpw(propertiesService.getString("fax.userpw"));

            //FAX 전송을(를) 등록 처리한다.
            retVal = faxService.send(faxDTO);
        } catch (Exception ex) {
            logger.error(ex.getMessage());
            retVal = -1;
        }

        if (retVal < 0) {
            return super.setResultSet(mav, DefaultConsts.ERR_CODE, "Fax발송 오류!");
        }

        return setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

}
