lst=[]
n=int(input("Enter Number of Elements:"))
for i in range(0,n):
     ele=int(input())
     lst.append(ele)
total=0
for num in lst:
    total +=num
print("The sum of the numbers is:",total)
     
