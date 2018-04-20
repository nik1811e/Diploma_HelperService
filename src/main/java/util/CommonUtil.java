package util;

import entity.CategoryEntity;
import entity.CourseEntity;
import entity.ResourceCategoryEntity;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

public class CommonUtil {
    private static final Logger logger = Logger.getLogger(CommonUtil.class);

    public static String loginOrEmail(String loginOrEmail) {
        String result = Pattern.compile(VariablesUtil.REGEXP_EMAIL,
                Pattern.CASE_INSENSITIVE).matcher(loginOrEmail).find() ? "email" : "login";
        logger.debug(CommonUtil.class.getName() + " loginOrEmail return: " + result);
        return result;
    }

    public static String getUUIDUserByLoginEmail(Session session, String loginOrEmail, String type) {
        String result = session.createQuery("SELECT a.uuid FROM " + VariablesUtil.ENTITY_AUTH_INFO
                + " a WHERE " + type + " = :cred").setParameter("cred", loginOrEmail).list().get(0).toString();
        logger.debug(CommonUtil.class.getName() + " getUUIDUserByLoginEmail return: " + result);
        return result;
    }

    public static int getIdAuthByUUID(Session session, String uuid) {
        int result = (int) session.createQuery("SELECT a.id FROM " + VariablesUtil.ENTITY_AUTH_INFO + " a WHERE" +
                " uuid = :uuid").setParameter("uuid", uuid).list().get(0);
        logger.debug(CommonUtil.class.getName() + " getIdUserByLoginEmail return: " + result);
        return result;
    }

    public static String getJsonStructure(Session session, String uuidCourse) {
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();

            return String.valueOf(session.createQuery("SELECT s.structure FROM " + VariablesUtil.ENTITY_COURSE + " s WHERE uuid = :uuid")
                    .setParameter("uuid", uuidCourse).list().get(0));

        } catch (Exception ex) {
            new MailUtil().sendErrorMailForAdmin("\n" + Arrays.toString(ex.getStackTrace()));
            logger.error(ex.getStackTrace());
            return null;
        }
    }

    public static List<CourseEntity> getCourseInformationByUuid(String uuidCourse) {
        logger.info("getCourseInformationByUuid");
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            return session.createQuery("SELECT c FROM " + VariablesUtil.ENTITY_COURSE + " c WHERE c.uuid =:uuidCourse", CourseEntity.class)
                    .setParameter("uuidCourse", uuidCourse).getResultList();
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage());
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
        return null;
    }

    public static List<CategoryEntity> getCourseCategory(){
        logger.info("getCourseCategory");
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            return session.createQuery("SELECT c FROM " + VariablesUtil.ENTITY_COURSE_CATEGORY + " c ").getResultList();
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage());
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
        return null;
    }
    public static List<ResourceCategoryEntity > getResourceCategory(){
        logger.info("getResourceCategory");
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            return session.createQuery("SELECT rc FROM " + VariablesUtil.ENTITY_RESOURCE_CATEGORY + " rc ").getResultList();
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage());
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
        return null;
    }

    public static void showMessage(HttpServletResponse resp, boolean success, String errorMessage, String successMessage) throws IOException {
        if (success) {
            PrintWriter printWriter = resp.getWriter();
            printWriter.println(successMessage);
        } else {
            PrintWriter printWriter = resp.getWriter();
            printWriter.println(errorMessage);
        }
    }
}
