package util;

import course.SectionInformation;
import entity.AuthInfEntity;
import entity.CategoryEntity;
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

    public static String getUuudAuthById(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            String result = session.createQuery("SELECT a.uuid FROM " + VariablesUtil.ENTITY_AUTH_INFO
                    + " a WHERE " + id + " =:id").setParameter("id", id).list().get(0).toString();
            logger.debug(CommonUtil.class.getName() + " getUUIDUserByLoginEmail return: " + result);
            return result;
        } catch (Exception ex) {
            return null;
        } finally {
            if (session.isOpen())
                session.close();
        }
    }

    public static int getIdAuthByUUID(Session session, String uuid) {
        int result = (int) session.createQuery("SELECT a.id FROM " + VariablesUtil.ENTITY_AUTH_INFO + " a WHERE" +
                " uuid = :uuid").setParameter("uuid", uuid).list().get(0);
        logger.debug(CommonUtil.class.getName() + " getIdUserByLoginEmail return: " + result);
        return result;
    }

    public static int getIdCourseByUUID(Session session, String uuid) {
        int result = (int) session.createQuery("SELECT a.id FROM CourseEntity a WHERE uuid =:uuid").setParameter("uuid", uuid).list().get(0);
        logger.debug(CommonUtil.class.getName() + " getIdCourseByUUID return: " + result);
        return result;
    }

    public static String getNameCategoryByid(int id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            return String.valueOf(session.createQuery("SELECT name FROM " + VariablesUtil.ENTITY_COURSE_CATEGORY + " WHERE id =:id")
                    .setParameter("id", id).list().get(0));
        } catch (Exception ex) {
            return null;
        } finally {
            if (session.isOpen())
                session.close();
        }
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

    public static List<CategoryEntity> getCourseCategory() {
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

    public static List<ResourceCategoryEntity> getResourceCategory() {
        logger.info("getResourceCategory");
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            return session.createQuery("SELECT rc FROM " + VariablesUtil.ENTITY_RESOURCE_CATEGORY + " rc ").getResultList();
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage());
            return null;
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }

    }

    public static List<AuthInfEntity> getUsers() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            return session.createQuery("SELECT a FROM " + VariablesUtil.ENTITY_AUTH_INFO + " a ORDER BY a.dateReg").getResultList();
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage());
            return null;
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
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

    public static boolean getAccessInformation(String uuidCourse, String uuidAuth) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            int idAuth = getIdAuthByUUID(session, uuidAuth);
            int idCourse = getIdCourseByUUID(session, uuidCourse);
            return session.createQuery("SELECT id FROM " + VariablesUtil.ENTITY_ACCEESS_INFO + " ac WHERE ac.idAuth =:idAuth and ac.idCourse =:idCourse")
                    .setParameter("idAuth", idAuth).setParameter("idCourse", idCourse).getResultList().isEmpty();
        } catch (Exception ex) {
            return false;
        } finally {
            if (session.isOpen())
                session.close();
        }
    }

    public static boolean checkAccess(String status, AuthInfEntity idCourseOwner, String uuidAuth, String uuidCourse) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            boolean accessEntity = getAccessInformation(uuidCourse, uuidAuth);
            if (status.equals("Открыт")) return true;
            if (!accessEntity) return true;
            return idCourseOwner.getId() == (getIdAuthByUUID(session, uuidAuth));
        } catch (Exception ex) {
            return false;
        } finally {
            if (session.isOpen())
                session.close();
        }

    }

    public static String getCourseNameByUuid(String uuidCourse) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction();
        try {
            return String.valueOf(session.createQuery("SELECT nameCourse FROM " + VariablesUtil.ENTITY_COURSE + "  WHERE uuid =:uuid")
                    .setParameter("uuid", uuidCourse).list().get(0));
        } catch (Exception ex) {
            return null;
        } finally {
            if (session.isOpen())
                session.close();
        }
    }

    public static String getSectionNameByUuid(String uuidSection) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.getTransaction();
        try {
            return new SectionInformation().getCourseSection(uuidSection)
                    .get(0).getName();
        } catch (Exception ex) {
            return null;
        } finally {
            if (session.isOpen())
                session.close();
        }
    }
}
