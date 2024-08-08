int w_count = 23;
int s_count = 15;
int y_count = 3;
char str = 'w';

void Automatic();
void manual();

void main() {
     ADCON1 = 7;
     trisA.B0 = 1;
     trisA.B1 = 1;
     trisA.B2 = 1;
     trisB = 0;
     portB = 0;
     trisC = 0;
     portC = 0;
     trisD = 0;
     portD = 0;

     while(1) {
              if (portA.B0 == 0) {
                 portd.B7 = 1;
                 if (portA.B1 == 1) {
                    Automatic();
                 }
                 else {
                    Manual();
                 }
              }
              else {

                   portB = 0;
                   portC = 0xff;
                   portD = 0;
              }
     }
}

void Automatic()
{
     w_count = 23;
     s_count = 15;
     while(portA.B0 != 1) {
                    if (str == 'w') {
                      if (w_count > 3) {
                         portd = 0b10001100;
                         portb = ((w_count % 10) << 4) + ((w_count - 3) % 10);
                         portc = 0b00000101; portc = 0;
                         portb = ((w_count / 10) << 4) + ((w_count - 3) / 10);
                         portc = 0b00001010; portc = 0;
                      }
                      else {
                         portd = 0b10001010;
                         portb = ((w_count % 10) << 4) + ((w_count) % 10);
                         portc = 0b00000101; portc = 0;
                         portb = ((w_count / 10) << 4) + ((w_count) / 10);
                         portc = 0b00001010; portc = 0;
                      }
                      delay_ms(500);
                      w_count--;
                      if (w_count == 0) {
                         w_count = 23;
                         str = 's';
                      }
                    }
                    else {
                      if (s_count > 3) {
                         portd = 0b10100001;
                         portb = (((s_count - 3) % 10) << 4) + (s_count % 10);
                         portc = 0b00000101; portc = 0;
                         portb = (((s_count - 3) / 10) << 4) + (s_count / 10);
                         portc = 0b00001010; portc = 0;
                      }
                      else {
                         portd = 0b10010001;
                         portb = ((s_count % 10) << 4) + ((s_count) % 10);
                         portc = 0b00000101; portc = 0;
                         portb = ((s_count / 10) << 4) + ((s_count) / 10);
                         portc = 0b00001010; portc = 0;
                      }
                      delay_ms(500);
                      s_count--;
                      if (s_count == 0) {
                         s_count = 23;
                         str = 'w';
                      }
                    }
                    if (portA.B1 != 1) {
                         break;
                    }
     }
}

void Manual()
{
     y_count = 3;
     while(portA.B0 != 1) {
                    if (str == 'w') {
                      if (portA.B2 == 1) {
                         portd = 0b10001100;
                         portb = 0;
                         portc = 0b00001111; portc = 0;
                         delay_ms(100);
                      }
                      else {
                         portd = 0b10001010;
                         portb = y_count + (y_count << 4);
                         portc = 0b00000101; portc = 0;
                         portb = 0;
                         portc = 0b00001010; portc = 0;
                         delay_ms(1000);
                         y_count--;
                         if (y_count == 0) {
                             y_count = 3;
                             str = 's';
                         }
                      }
                    }
                    else {
                      if (portA.B2 != 1) {
                         portd = 0b10100001;
                         portb = 0;
                         portc = 0b00001111; portc = 0;
                         delay_ms(100);
                      }
                      else {
                         portd = 0b10010001;
                         portb = y_count + (y_count << 4);
                         portc = 0b00000101; portc = 0;
                         portb = 0;
                         portc = 0b00001010; portc = 0;
                         delay_ms(1000);
                         y_count--;
                         if (y_count == 0) {
                             y_count = 3;
                             str = 'w';
                         }
                      }
                    }
                    if (portA.B1 == 1) {
                         break;
                    }
     }
}