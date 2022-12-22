package com.hwfs.ft.ftp.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.ftp.dao.ProposalDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * AuthorityServiceImpl에 대한 설명 작성
 * @ClassName ProposalServiceImpl.javaServiceImpl.java
 * @Description ProposalServiceImpl.javaServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 02. 24.   KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : KJJ
 * @since 2015. 02. 24.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/ftp/proposalService")
public class ProposalServiceImpl extends DefaultServiceImpl implements ProposalService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** AuthorityDAO */
    @Resource(name="/ft/ftp/proposalDAO")
    private ProposalDAO proposalDAO;

    /** AttachFile Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /** GwIfDAO Bean 생성 */
    @Resource(name = "/sc/cmn/gwIfDAO")
    private GwIfDAO gwIfDAO;

    /**
     * 구매 품의 마스터을 조회한다.
     * <pre>
     * 구매 품의 마스터을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public RecordSet selectPoOrderList(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.selectPoOrderList(inVar);	//TODO 추후 작업
    }

    /**
     * 품의 상신
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#proposalDraft(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int proposalDraft(LoginDTO loginParameter, DataSetMap search, DataSetMap dsProposalList )  throws Exception {
        int procCnt = 0;

        logger.info("dsProposalList.size() ::"+dsProposalList.size());
        if ( dsProposalList.size() > 0 ) {
            for (int i = 0 ; i < dsProposalList.size() ; i++) {
                Map<String, Object> parameter = dsProposalList.get(i);

                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                parameter.put("poProposalStatus", "20");	//상신

                logger.info("signInstanceId ::"+parameter.get("signInstanceId"));
                //1.품의상태:상신중 update
                String proposalUpnewDate = LimsUtil.getDate("yyyyMMdd");
                parameter.put("proposalUpnewDate", proposalUpnewDate);
                procCnt += proposalDAO.updatePoProposalDraft( parameter );

                //2.그룹웨어와 I/F - 정의 되면 구현

                //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                gwIfDAO.saveSignInfo(parameter);

            }
        }

        return procCnt;
    }

    /**
     * 품의 삭제
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#proposalDraft(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int deletePoProposalMst(LoginDTO loginParameter, DataSetMap search, DataSetMap dsProposalList ) {
        int procCnt = 0;

        if ( dsProposalList.size() > 0 ) {
            for (int i = 0 ; i < dsProposalList.size() ; i++) {
                Map<String, Object> parameter = dsProposalList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());

                procCnt += proposalDAO.deletePoProposalMst( parameter );
            }
        }

        return procCnt;
    }

    /**
     * 구매 품의 마스터 시퀀스을 조회한다.
     * <pre>
     * 구매 품의 마스터 시퀀스을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public String getPoProposalMstS(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.getPoProposalMstS(inVar);	//TODO 추후 작업
    }


    /**
     * 구매 품의 마스터을 조회한다.
     * <pre>
     * 구매 품의 마스터을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public RecordSet selectProposalDtl(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.selectProposalDtl(inVar);	//TODO 추후 작업
    }

    /**
     * 구매 품의 마스터을 조회한다.
     * <pre>
     * 구매 품의 마스터을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public RecordSet selectCallProposalDtl(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.selectCallProposalDtl(inVar);	//TODO 추후 작업
    }

    /**
     * 구매 품의 품목 상세를 조회한다.
     *
     * @param inVar
     * @throws Exception
     */
    @Override
    public RecordSet selectPoProposalItemDtlList(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.selectPoProposalItemDtlList(inVar);	//TODO 추후 작업
    }

    /**
     * 구매 품의 품목 sum를 조회한다.
     *
     * @param inVar
     * @throws Exception
     */
    @Override
    public RecordSet selectPoProposalItemDtlSum(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.selectPoProposalItemDtlSum(inVar);	//TODO 추후 작업
    }
    /**
     * 구매 품의 지불 조건를 조회한다.
     *
     * @param inVar
     * @throws Exception
     */
    @Override
    public RecordSet selectPoProposalPayCondList(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.selectPoProposalPayCondList(inVar);	//TODO 추후 작업
    }
    /**
     * 구매 품의 벌점 조건를 조회한다.
     *
     * @param inVar
     * @throws Exception
     */
    @Override
    public RecordSet selectPoProposalBlckMarkCondList(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.selectPoProposalBlckMarkCondList(inVar);	//TODO 추후 작업
    }

    /**
     * saveProposalDtl 설명
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveProposalDtl(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveProposalDtl(LoginDTO loginParameter, DataSetMap search, DataSetMap proposalInfo, DataSetMap itemList, DataSetMap payList, DataSetMap blckMarkList, DataSetMap file, DataSetMap file2) throws Exception  {
        int proposalProcCnt = 0;
        int itemProcCnt = 0;
        int payProcCnt = 0;
        int blckMarkProcCnt = 0;
        int fileCnt = 0;
        int fileCnt2 = 0;
        String poProposalNum = "";	//구매품의 번호

        poProposalNum = LimsUtil.checkNull(search.get(0).get("poProposalNum"));
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");
        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();

        String strRefSeq = "";	//첨부참조일련번호
        String strUploadPath = propertiesService.getString("global.imagerepository.path")+"/"+propertiesService.getString("ft.file.path")+"/ftp";
        logger.info( "strUploadPath  ::::"+strUploadPath );

        File saveFolder = new File(strUploadPath);
        // 디렉토리 생성
        logger.info( "saveFolder.exists()  ::::"+saveFolder.exists()+"//"+saveFolder.isFile());
        if (!saveFolder.exists() || saveFolder.isFile()) {
            logger.info( "==================");
            saveFolder.mkdirs();
        }


//        String strRefSeq = null;	//거래 구조 이미지
        logger.info("file.size()  :"+file.size() );
        if ( file.size() > 0 ) {
            strRefSeq = attachFileService.save(file, propertiesService.getString("ft.file.path")+"/ftp", false, true, true);
            fileCnt++;
            logger.info("strRefSeq :::"+strRefSeq);
        }

        String strRefSeq2 = null;	//첨부참조일련번호
        logger.info("file2.size()  :"+file2.size() );
        if ( file2.size() > 0 ) {
            strRefSeq2 = attachFileService.save(file2, propertiesService.getString("ft.ftp.proposal.file.path"), false);
            fileCnt2++;
            logger.info("fileRefSrlNum:"+strRefSeq2);
        }

        //1.구매 품의 마스터 저장
        // Detail로 Sum등이 있어서 여기서는 품의번호만 채번하고 하단에서 Insert / Update처리 한다.
        if ( proposalInfo.size() > 0  || strRefSeq !=null   || strRefSeq2 !=null ) {
            for (int i = 0 ; i < proposalInfo.size() ; i++) {
                Map<String, Object> parameter = proposalInfo.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());

                if ( !"".equals(strRefSeq) ) {
                    parameter.put("dealStructImgeSrlnum", strRefSeq);	//거래 구조 이미지 일련번호
                } else {
                    parameter.put("dealStructImgeSrlnum", parameter.get("dealStructImgeSrlnum") );	//거래 구조 이미지 일련번호
                }

                if ( !"".equals(strRefSeq2) ) {
                    parameter.put("fileRefSrlNum", strRefSeq2);			//파일 참조 일련 번호(별첨)
                } else {
                    parameter.put("fileRefSrlNum", parameter.get("fileRefSrlNum"));			//파일 참조 일련 번호(별첨)
                }
                logger.info("dealStructImgeSrlnum :::"+parameter.get("dealStructImgeSrlnum"));
                logger.info("fileRefSrlNum :::"+parameter.get("fileRefSrlNum"));
                //int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( search.get(0).get("flag").equals("NEW") || search.get(0).get("flag").equals("COPY") ) {	//신규, 품의카피
                    //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
                    poProposalNum = proposalDAO.getPoProposalMstS(parameter);

                    String currYymm = LimsUtil.getDate("yyMM");
                    if ( "10".equals(parameter.get("poType") )) {	//수입
                        poProposalNum = "PR"+"100"+currYymm+poProposalNum;
                    } else {
                        poProposalNum = "PR"+"300"+currYymm+poProposalNum;
                    }

                    parameter.put("poProposalNum", poProposalNum);
                    if ( "B".equals(parameter.get("proposalClass").toString()) ) {	//구릅웨어 품의
                        if ( "TEMP".equals(search.get(0).get("temp").toString()) ){ //임시저장
                            parameter.put("poProposalStatus", "10");	//작성중
                        } else {
                            parameter.put("poProposalStatus", "30");	//승인완료
                        }
                    } else {
                        parameter.put("poProposalStatus", "10");	//구매품의상태 : 작성중
                        parameter.put("proposalWriteDate", currYymmdd);		//품의작성일자 :현재날짜
                        parameter.put("proposalUpnewDate", "");		//품의상신일자 :''
                        parameter.put("proposalApprvDate", "");		//품의승인일자 :''
                        parameter.put("groupProposalNum", "");		//그룹웨어 품의 번호 :''
                        parameter.put("signInstanceId", "");		//결재 INSTANCE_ID :''
                    }

                    logger.info("currYymmdd :::"+currYymmdd);

                    //proposalProcCnt += proposalDAO.insertPoProposal(parameter);
                } else {
                    if ( "B".equals(parameter.get("proposalClass").toString()) ) {	//구릅웨어 품의
                        if ( "TEMP".equals(search.get(0).get("temp").toString()) ) {	//임시저장
                            parameter.put("poProposalStatus", "10");	//작성중
                        } else {
                            parameter.put("poProposalStatus", "30");	//승인완료
                        }

                    }
                    //proposalProcCnt += proposalDAO.updatePoProposal(parameter);
                    poProposalNum = parameter.get("poProposalNum").toString();
                }
            }
        }

        logger.info( "poProposalNum  ::::"+poProposalNum );
        //2.구매 품의 품목 상세 저장
        if ( itemList.size() > 0 ) {
            for (int i = 0 ; i < itemList.size() ; i++) {
                Map<String, Object> parameter = itemList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( search.get(0).get("flag").equals("NEW") || search.get(0).get("flag").equals("COPY") ) {	//신규, 품의카피
                    parameter.put("poProposalNum", poProposalNum);
                }
                if (rowType == DataSet.ROW_TYPE_DELETED) {
                    itemProcCnt += proposalDAO.deleteProposalItemList(parameter);
                }
                poProposalNum = parameter.get("poProposalNum").toString();
            }
            for (int i = 0 ; i < itemList.size() ; i++) {
                Map<String, Object> parameter = itemList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( search.get(0).get("flag").equals("NEW") || search.get(0).get("flag").equals("COPY") ) {	//신규, 품의카피
                    parameter.put("poProposalNum", poProposalNum);
                }
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    itemProcCnt += proposalDAO.insertProposalItemList(parameter);
                }
                poProposalNum = parameter.get("poProposalNum").toString();
            }
            for (int i = 0 ; i < itemList.size() ; i++) {
                Map<String, Object> parameter = itemList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( search.get(0).get("flag").equals("NEW") || search.get(0).get("flag").equals("COPY") ) {	//신규, 품의카피
                    parameter.put("poProposalNum", poProposalNum);
                }
                if (rowType == DataSet.ROW_TYPE_UPDATED){
                    itemProcCnt += proposalDAO.updateProposalItemList(parameter);
                }
                poProposalNum = parameter.get("poProposalNum").toString();
            }
        }

        //3.구매 품의 지불 조건 저장
        if ( payList.size() > 0 ) {
            for (int i = 0 ; i < payList.size() ; i++) {
                Map<String, Object> parameter = payList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                if ( search.get(0).get("flag").equals("NEW") || search.get(0).get("flag").equals("COPY") ) {	//신규, 품의카피
                    parameter.put("poProposalNum", poProposalNum);
                }

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    payProcCnt += proposalDAO.insertProposalPayList(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    payProcCnt += proposalDAO.updateProposalPayList(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    payProcCnt += proposalDAO.deleteProposalPayList(parameter);
                }
                poProposalNum = parameter.get("poProposalNum").toString();
            }
        }

        //4.구매 품의 벌점 조건 저장
        if ( blckMarkList.size() > 0 ) {
            for (int i = 0 ; i < blckMarkList.size() ; i++) {
                Map<String, Object> parameter = blckMarkList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                if ( search.get(0).get("flag").equals("NEW") || search.get(0).get("flag").equals("COPY") ) {	//신규, 품의카피
                    parameter.put("poProposalNum", poProposalNum);
                }

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    blckMarkProcCnt += proposalDAO.insertProposalBlckMarkList(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    blckMarkProcCnt += proposalDAO.updateProposalBlckMarkList(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    blckMarkProcCnt += proposalDAO.deleteProposalBlckMarkList(parameter);
                }
                poProposalNum = parameter.get("poProposalNum").toString();
            }
        }

        // Detail들이 입력된 후 Master를 등록해야 한다.
        // 각 Detail들의 데이터를 가지고 Sum을 하는 부분이 있기 때문에
        for (int i = 0 ; i < proposalInfo.size() ; i++) {
            Map<String, Object> parameter = proposalInfo.get(i);
            parameter.put("cuser", loginParameter.getSabun());
            parameter.put("uuser", loginParameter.getSabun());

            if ( !"".equals(strRefSeq) ) {
                parameter.put("dealStructImgeSrlnum", strRefSeq);	//거래 구조 이미지 일련번호
            } else {
                parameter.put("dealStructImgeSrlnum", parameter.get("dealStructImgeSrlnum") );	//거래 구조 이미지 일련번호
            }

            if ( !"".equals(strRefSeq2) ) {
                parameter.put("fileRefSrlNum", strRefSeq2);			//파일 참조 일련 번호(별첨)
            } else {
                parameter.put("fileRefSrlNum", parameter.get("fileRefSrlNum"));			//파일 참조 일련 번호(별첨)
            }

            logger.info("dealStructImgeSrlnum :::"+parameter.get("dealStructImgeSrlnum"));
            logger.info("fileRefSrlNum :::"+parameter.get("fileRefSrlNum"));
            //int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if ( search.get(0).get("flag").equals("NEW") || search.get(0).get("flag").equals("COPY") ) {	//신규, 품의카피
                // 품의번호는 위해서 생성한다.
                //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
                //poProposalNum = proposalDAO.getPoProposalMstS(parameter);

                /*String currYymm = LimsUtil.getDate("yyMM");
                if ( "10".equals(parameter.get("poType") )) {	//수입
                    poProposalNum = "PR"+"100"+currYymm+poProposalNum;
                } else {
                    poProposalNum = "PR"+"300"+currYymm+poProposalNum;
                }*/

                parameter.put("poProposalNum", poProposalNum);
                if ( "B".equals(parameter.get("proposalClass").toString()) ) {	//구릅웨어 품의
                    if ( "TEMP".equals(search.get(0).get("temp").toString()) )	{ //임시저장
                        parameter.put("poProposalStatus", "10");	//작성중
                    } else {
                        parameter.put("poProposalStatus", "30");	//승인완료
                    }
                } else {
                    parameter.put("poProposalStatus", "10");	//구매품의상태 : 작성중
                    parameter.put("proposalWriteDate", currYymmdd);		//품의작성일자 :현재날짜
                    parameter.put("proposalUpnewDate", "");		//품의상신일자 :''
                    parameter.put("proposalApprvDate", "");		//품의승인일자 :''
                    parameter.put("groupProposalNum", "");		//그룹웨어 품의 번호 :''
                    parameter.put("signInstanceId", "");		//결재 INSTANCE_ID :''
                }

                logger.info("currYymmdd :::"+currYymmdd);

                proposalProcCnt += proposalDAO.insertPoProposal(parameter);
            } else {
                if ( "B".equals(parameter.get("proposalClass").toString()) ) {	//구릅웨어 품의
                    if ( "TEMP".equals(search.get(0).get("temp").toString()) ) {	//임시저장
                        parameter.put("poProposalStatus", "10");	//작성중
                    } else {
                        parameter.put("poProposalStatus", "30");	//승인완료
                    }
                }
                proposalProcCnt += proposalDAO.updatePoProposal(parameter);
                poProposalNum = parameter.get("poProposalNum").toString();
            }
        }

        logger.info("poProposalNum2 :"+poProposalNum);
        map.put("poProposalNum", poProposalNum);	//구매품의 번호 전달
        map.put("procCnt", proposalProcCnt+itemProcCnt+payProcCnt+blckMarkProcCnt+fileCnt+fileCnt2);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * 구매 품의 마스터을 조회한다.
     * <pre>
     * 구매 품의 마스터을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public RecordSet selectProposalSearchPop(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.selectProposalSearchPop(inVar);	//TODO 추후 작업
    }

    /**
     * 환율을 조회한다.
     * <pre>
     * 구매 품의 마스터 시퀀스을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public Record getExchangeRate(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.getExchangeRate(inVar);	//TODO 추후 작업
    }

    /**
     * 단위변경시 단위에 해당하는 실단위 가져오기
     * <pre>
     * 구매 품의 마스터 시퀀스을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public Record getUnitInfo(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.getUnitInfo(inVar);	//TODO 추후 작업
    }

    /**
     * 수수료구분 변경시 계정정보 가져오기
     * <pre>
     * 수수료구분 변경시 계정정보 가져오기
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public Record getAccCdInfo(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.getAccCdInfo(inVar);	//TODO 추후 작업
    }

    /**
     * BL번호 중복체크
     * <pre>
     * BL번호 중복체크
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public Record chkDupBlnum(Map<String, Object> inVar)
            throws Exception {
        return proposalDAO.chkDupBlnum(inVar);	//TODO 추후 작업
    }
}

