package com.hwfs.guide.sample.web;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.cmn.jms.MessageReader;
import com.hwfs.cmn.jms.MessageWriter;
import com.hwfs.cmn.service.ComCacheService;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.cmn.util.CryptoUtil;
import com.hwfs.sc.cmn.dto.FaxDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.rmi.RmiClient;
import com.hwfs.sc.cmn.service.FaxService;
import com.hwfs.sc.cmn.service.SmsSendService;

@Controller
public class TestFuncController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** propertiesService */
	//@Resource(name = "propertiesService")
    @Autowired
	protected PropertiesService propertiesService;
	
	/** messageService */
    @Autowired
    private MessageSourceAccessor messageService;

//	/** accessLogService */
//    @Resource(name = "accessLogService")
//    private AccessLogService accessLogService;

    /** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;

    /** UUIdGenService */
    @Resource(name = "idGenUUIdService")
    protected UUIdGenService idGenUUIdService;

    /** SequenceIdGenService */
    @Resource(name = "idGenSequenceTest")
    protected SequenceIdGenService idGenSequenceTest;

	@Autowired
	private ComCacheService cacheService;

    /** JMS Read Service */
    @Autowired
    protected MessageReader messageReader;

    /** JMS Write Service */
    @Autowired
    protected MessageWriter messageWriter;

    /** RMI Service Client */
    @Resource(name = "rmiClient")
    protected RmiClient rmiClient;

	/** SmsSendService Bean ?????? */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;

	/** FaxService Bean ?????? */
	@Resource(name = "/sc/cmn/faxService")
	private FaxService faxService;
	

    /**
     * /guide/sample/TestFunc.jsp ????????? ????????? ??????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testFunc.do")
    public String testFunc() throws Exception {
    	logger.debug("****************TestFunc{}{}{}",1,2,3);
    	//System.out.println ("*****************************lll");
        return "/guide/test/TestFunc";
    } 

    /**
     * Properties ?????????
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testProperties.do")
    public ModelAndView testProperties() throws Exception {
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();
    	bufResult.append(String.format("Properties_Test******************global.fileupload.path=%s", propertiesService.getString("global.fileupload.path")));
    	bufResult.append(String.format("<br>Properties_Test******************autologin.userId=%s", propertiesService.getString("autologin.userId")));
    	
    	mav.addObject("resultMsg", bufResult.toString().replace("\n", ""));
    	
    	mav.setViewName("/guide/test/TestFunc");
        return mav;
    } 

    /**
     * Message Locale ?????????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testLocale.do")
    public ModelAndView testLocale() throws Exception {
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	String[] params = {"aaa", "bbb"}; // ???????????? ?????? parameter
    	//??????????????? Locale??? ??????????????? ???????????? ?????? ?????? : messageService.getMessage("message.test03", params);
    	bufResult.append(String.format("Locale Test******************Locale=%s, message=%s", Locale.getDefault(), messageService.getMessage("message.test03", params, Locale.KOREAN))); //???????????????
    	bufResult.append(String.format("<br>Locale Test******************Locale=%s, message=%s", Locale.getDefault(), messageService.getMessage("message.test03", params)));			//????????????
    	bufResult.append(String.format("<br>Locale Test******************Locale=%s, message=%s", Locale.getDefault(), messageService.getMessage("message.test03", params, Locale.US)));	//???????????????
    	
    	mav.addObject("resultMsg", bufResult.toString().replace("\n", ""));
    	mav.setViewName("/guide/test/TestFunc");
    	
    	//test logger
    	try {
    		int i=10/0;
    	}catch(Exception e){
    		logger.error("error", e);
    	}
        return mav;
    }
    
    /**
     * ????????? ????????? ???????????? ?????????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testEncDec.do")
    public ModelAndView testEncDec() throws Exception {
    	String[] testString = { "This is a testing...\nHello!",
    							"?????? ??????????????????...",
    							"!@#$%^&*()_+|~{}:\"<>?-=\\`[];',./" };
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	try {
			//SHA-256 ????????? ???????????? Hash
	    	bufResult.append("?????????*******1234abcd=" + CryptoUtil.encryptPassword("1234abcd") +"\n");
	    	bufResult.append("HASH  *******1234abcd=" + CryptoUtil.getHash("1234abcd") +"\n");
			
	    	//ARIA Crypto Service
	    	for (String str : testString) {
				byte[] encrypted = cryptoService.encrypt(str.getBytes("UTF-8"));
				byte[] decrypted = cryptoService.decrypt(encrypted);
				String strTmp = String.format("??????=%s, ?????????=%s, ?????????=%s\n", str, encrypted.toString(), new String(decrypted, "UTF-8"));
				logger.debug (strTmp);
				bufResult.append(String.format("?????????*******%s",strTmp));
			}

		} catch (Exception e) {
			logger.error(e.getMessage());
			bufResult.append("Error*******");
			bufResult.append(e.getMessage());
		}
    	logger.debug(bufResult.toString());
    	mav.addObject("resultMsg", bufResult.toString().replace("\n", ""));
    	mav.setViewName("/guide/test/TestFunc");
    	return mav;
    } 

    /**
     * ?????? ????????? ???????????? ?????????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testEncDecFile.do")
    public String testEncDecFile() throws Exception {

//    	String filePath = propertiesService.getString("global.fileupload.path"); //"/META-INF/spring/file/test.txt";
//    	File fileSrc = new File(filePath + "/" + "test.txt"); //this.getClass().getResource(filePath).getFile());
//    	File fileEncrypted = new File(filePath + "/" + "test.txt.encrypted");
//    	File fileDecrypted = new File(filePath + "/" + "test-decrypted.txt");
		String orgFileName = "D:/test/AA????????????.xlsx";
		String encFileName = "D:/test/AA????????????-enc.xlsx";
		String decFileName = "D:/test/AA????????????-dec.xlsx";

    	try {
    		//?????? ????????? ??????
    		cryptoService.encryptFile(orgFileName, encFileName);
    		cryptoService.decryptFile(encFileName, decFileName);
     	} catch (Exception e) {
    		logger.error(e.getMessage());
    	}
    	return "/guide/test/TestFunc";
    }

    /**
     * UUID ?????????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testUUID.do")
    public ModelAndView testUUID() throws Exception {
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	bufResult.append("Sequence UUID=" + idGenSequenceTest.getNextStringId() + "<br>");
    	bufResult.append("Random   UUID=" + idGenUUIdService.getNextStringId() + "<br>");
    	bufResult.append("Host     UUID=" + idGenUUIdService.getNextStringHostId() + "<br>");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * Cache ?????????
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testCache.do")
    public ModelAndView testCache() throws Exception {
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	//Cache ????????????
    	String cacheId = "TEST-AA";
    	String cacheVal;
    	if(cacheService.contains(cacheId)) {
    		cacheVal = (String) cacheService.get(cacheId, String.class);
    	}
    	else {
    		cacheVal = "TEST_AA Value";
    		cacheService.put(cacheId, cacheVal);
    	}
    	
    	bufResult.append(String.format("Cache_Test******************%s=%s", cacheId, cacheVal));
    	mav.addObject("resultMsg", bufResult.toString().replace("\n", ""));
    	
    	mav.setViewName("/guide/test/TestFunc");
        return mav;
    } 

    /**
     * JMS Read/Write Blocking?????? ?????????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testJmsBlocking.do")
    public ModelAndView testJmsBlocking() throws Exception {
    	
    	String writeMsg = "??????????????????...abce!@#$%1234";
    	messageWriter.writeMessage(writeMsg);
    	String readMsg = (String)messageReader.readMessage();
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	bufResult.append("write message=" + writeMsg + "<br>");
    	bufResult.append("read  message=" + readMsg + "<br>");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * JMS Read/Write NonBlocking?????? ?????????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testJmsNonBlocking.do")
    public ModelAndView testJmsNonBlocking() throws Exception {
    	
    	String writeMsg = "NonBlocking ??????????????????...abce!@#$%1234";
    	messageWriter.writeMessage(writeMsg);
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	bufResult.append("write message=" + writeMsg + "<br>");
    	bufResult.append("?????????????????? ???????????? ?????? ???????????? ???????????????.<br>");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * CSRF Test
     *
     * @return
     * @throws Exception
     */
    @ValidationToken
    @RequestMapping(value="/guide/test/testCSRF.do")
    public ModelAndView testCSRF() throws Exception {
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	bufResult.append("CSRF Test OK...");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * AccessLog Test
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testAccessLog.do")
    public ModelAndView testAccessLog() throws Exception {
    	ModelAndView mav = new ModelAndView ();

    	//accessLogService.logTest();
    	//accessLogService.readLog("a=b",10);

    	StringBuffer bufResult = new StringBuffer();
    	bufResult.append("AccessLog Test OK...--> SCC_ACES_LOG????????? ??????");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * RMI??? ???????????? ????????? ?????? ????????? ?????? ?????????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testRmiIsAliveServer.do")
    public ModelAndView testRmiIsAliveServer() throws Exception {
    	logger.debug("****************testRmiIsAliveServer");
    	//rmiServiceClient.setServiceUrl(serviceUrl);
    	
    	boolean isAlive = rmiClient.isAliveServer();
    	logger.debug("****************testRmiIsAliveServer result : {}", isAlive);

    	ModelAndView mav = new ModelAndView ();
    	mav.addObject("resultMsg", isAlive);
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    } 

    /**
     * SMS ?????? ?????????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testSms.do")
    public ModelAndView testSms() throws Exception {
    	
		SmsDTO smsDTO = new SmsDTO();
		smsDTO.setTrPhone("01086539182");			//????????? ????????????
		smsDTO.setTrMsg("SMS ?????? ?????? ?????????!");	//?????? ?????????
		
		//?????????????????? ?????? ????????? ?????? ??????????????? ????????????. (????????? ?????? ??????)
		smsDTO.setTrCallback(propertiesService.getString("ems.sms.callback.no", ""));
		
		//????????? ?????? : ??????
		
		smsDTO.setTrCcId(propertiesService.getString("ems.sms.cmn.send.deptId", "")); 			//?????? ????????????
		smsDTO.setTrUserId(propertiesService.getString("ems.sms.cmn.send.defaultSabun", ""));	//????????? ?????????
		smsDTO.setTrCustNo("");				//??????????????? ???????????? ?????????????????? ????????????.
		
		logger.info("SMS ?????? Test={}", smsDTO.toString());
		smsSendService.saveSms(smsDTO);
		
    	ModelAndView mav = new ModelAndView ();
    	mav.addObject("resultMsg", smsDTO.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    } 

    /**
     * FAX ?????? ?????????
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testFax.do")
    public ModelAndView testFax() throws Exception {
    	
		//FAX ????????????
		FaxDTO faxDTO = new FaxDTO();
		faxDTO.setRecipient("?????????");
		faxDTO.setFaxno("0222860898");
		faxDTO.setFilename(propertiesService.getString("global.filerepository.path") + "/" + "faxtest.pdf");
		
		//????????? ????????? ??????
		faxDTO.setUserid(propertiesService.getString("fax.userid"));	
		faxDTO.setUserpw(propertiesService.getString("fax.userpw"));
		
		//FAX ?????????(???) ?????? ????????????.
		int processCnt = faxService.send(faxDTO);

		logger.info("FAX ?????? Test={}", faxDTO.toString());
		
    	ModelAndView mav = new ModelAndView ();
    	mav.addObject("resultMsg", processCnt + "??? ?????? : " + faxDTO.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    } 
}
