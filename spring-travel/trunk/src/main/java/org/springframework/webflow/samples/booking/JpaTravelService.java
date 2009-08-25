package org.springframework.webflow.samples.booking;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

/**
 * A JPA-based implementation of the Booking Service. Delegates to a JPA entity manager to issue data access calls
 * against the backing repository. The EntityManager reference is provided by the managing container (Spring)
 * automatically.
 */
@Service("travelService")
@Repository
public class JpaTravelService implements TravelService {

    private EntityManager em;

    @PersistenceContext
    public void setEntityManager(EntityManager em) {
	this.em = em;
    }

    @Transactional(readOnly = true)
    @SuppressWarnings("unchecked")
    public List<Booking> findBookings(String username) {
	if (username != null) {
	    return em.createQuery("select b from Booking b where b.user.username = :username order by b.checkinDate")
		    .setParameter("username", username).getResultList();
	} else {
	    return null;
	}
    }

    @Transactional(readOnly = true)
    @SuppressWarnings("unchecked")
    public List<Hotel> findHotels(SearchCriteria criteria) {
	String pattern = getSearchPattern(criteria);
	return em.createQuery(
		"select h from Hotel h where lower(h.name) like " + pattern + " or lower(h.city) like " + pattern
			+ " or lower(h.zip) like " + pattern + " or lower(h.address) like " + pattern).setMaxResults(
		criteria.getPageSize()).setFirstResult(criteria.getPage() * criteria.getPageSize()).getResultList();
    }

    @Transactional(readOnly = true)
    public Hotel findHotelById(Long id) {
	return em.find(Hotel.class, id);
    }

    @Transactional(readOnly = true)
    public Booking createBooking(Long hotelId, String username) {
	Hotel hotel = em.find(Hotel.class, hotelId);
	User user = findUser(username);
	Booking booking = new Booking(hotel, user);
	em.persist(booking);
	return booking;
    }

    @Transactional
    public void cancelBooking(Long id) {
	Booking booking = em.find(Booking.class, id);
	if (booking != null) {
	    em.remove(booking);
	}
    }

    @Transactional
    public Preference addPreference(String userName, Preference preference) {
	User user = findUser(userName);
	preference.setUser(user);
	em.persist(preference);
	return preference;
    }

    @Transactional
    public void deletePreference(Long id) {
	Preference preference = em.find(Preference.class, id);
	if (preference != null) {
	    em.remove(preference);
	}
    }

    @SuppressWarnings("unchecked")
    @Transactional(readOnly = true)
    public List<Preference> findPreferences(String username) {
	if (username != null) {
	    return em.createQuery("select p from Preference p where p.user.username = :username").setParameter(
		    "username", username).getResultList();
	} else {
	    return null;
	}
    }

    @Transactional
    public Preference findPreferenceById(Long id) {
	return em.find(Preference.class, id);
    }

    @Transactional
    public void savePreference(Preference preference) {
	em.merge(preference);
    }

    // helpers

    private String getSearchPattern(SearchCriteria criteria) {
	if (StringUtils.hasText(criteria.getSearchString())) {
	    return "'%" + criteria.getSearchString().toLowerCase().replace('*', '%') + "%'";
	} else {
	    return "'%'";
	}
    }

    private User findUser(String username) {
	return (User) em.createQuery("select u from User u where u.username = :username").setParameter("username",
		username).getSingleResult();
    }

    @Transactional
    public Hotel addHotel(Hotel hotel) {
	em.persist(hotel);
	return hotel;
    }

}