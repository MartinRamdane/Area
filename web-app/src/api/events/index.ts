import axios from 'axios';
import { API_URL, ApiEvent, EventCreate, EventType } from '../constants';

export const getTriggers = async (): Promise<ApiEvent[]> => {
  try {
    return (await axios.get(API_URL + '/events/trigger')).data as ApiEvent[];
  } catch (error) {
    throw new Error('Error getting triggers.');
  }
};

export const getResponses = async (): Promise<ApiEvent[]> => {
  try {
    return (await axios.get(API_URL + '/events/response')).data as ApiEvent[];
  } catch (error) {
    throw new Error('Error getting responses.');
  }
};

export const createEvent = async (payload: EventCreate): Promise<void> => {
  try {
    await axios.post(API_URL + '/event/create', payload, {
      headers: {
        Authorization: `Bearer ${localStorage.getItem('authToken')}`,
      },
    });
  } catch (error) {
    throw new Error('Error creating event.');
  }
};

export const getEvents = async (): Promise<EventType[]> => {
  try {
    const res = await axios.get(API_URL + '/user/events', {
      headers: {
        Authorization: `Bearer ${localStorage.getItem('authToken')}`,
      },
    });
    return res.data;
  } catch (error) {
    throw new Error('Error getting events.');
  }
};

export const activateEvent = async (payload: {
  uuid: string;
  activated: boolean;
}): Promise<void> => {
  try {
    await axios.patch(
      API_URL + `/events/activate/${payload.uuid}`,
      {
        activated: payload.activated,
      },
      {
        headers: {
          Authorization: `Bearer ${localStorage.getItem('authToken')}`,
        },
      },
    );
  } catch (error) {
    throw new Error('Error activating event.');
  }
};