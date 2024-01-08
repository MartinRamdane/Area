import styled from 'styled-components';
import { Button, DialogContent, DialogHeader } from '@/components/ui';

export const Modal = styled(DialogContent)`
  min-width: 320px;
  width: 100%;
  padding: 24px;
  gap: 16px;
`;

export const Header = styled(DialogHeader)`
  gap: 6px;
  flex-direction: column;
`;

export const EventPanelButton = styled(Button)`
  padding: 10px;
  width: 100%;
  gap: 10px;
`;

export const Page = styled.div`
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding-right: 24px;
`;

export const LabelContent = styled.div`
  display: flex;
  flex-direction: column;
  gap: 10px;
`;

export const ServiceContainer = styled.div`
  display: flex;
  flex-direction: column;
  gap: 8px;
`;

export const Title = styled.div`
  display: flex;
  flex-direction: column;
`;
