import os
from fpdf import FPDF
from faker import Faker

Faker.seed(202393610)
fake = Faker()

def create(size):
    folder_name = os.path.join("batch_size",str(size))
    os.makedirs(folder_name, exist_ok=True)

    for i in range(size):
        width = len(str(size))
        name = fake.name()
        cert_id = fake.uuid4()
        

        pdf = FPDF(orientation="L", unit="mm", format="A4")
        pdf.add_page()
        

        pdf.image("logo.png", x=-10, y=2, w=100)    
        pdf.set_line_width(2)
        pdf.rect(10, 10, 277, 190) 
        
        pdf.set_font("helvetica", "B", 25)
        pdf.text(x=70, y=30, text="King Fahd University of Petroleum and Minerals")
        pdf.text(x=70, y=40, text="College of Computing and Mathematics")
        pdf.text(x=70, y=50, text="Information and Computer Science Department")

        pdf.set_font("helvetica", "B", 45)
        pdf.text(x=80, y=80, text="Academic Diploma")
        
        pdf.set_font("helvetica", "", 20)
        pdf.text(x=115, y=90, text="Awarded to:")
        
        pdf.set_font("helvetica", "I", 35)
        pdf.text(x=100, y=115, text=name)
        
        pdf.set_font("helvetica", "I", 15)
        pdf.text(x=80, y=125, text="For successfully completing the course for Bitcoiners in 2026.")
        
        pdf.set_font("helvetica", "", 12)
        pdf.text(x=105, y=180, text=f"ID de Verificación: {cert_id}")
        filename = f"doc_{i+1:0{width}d}_{cert_id[:5]}.pdf"
        path = os.path.join(folder_name, filename) 
        
        pdf.output(path)


if __name__ == "__main__":
    
    for i in [1,2,8]:
        create(i)
