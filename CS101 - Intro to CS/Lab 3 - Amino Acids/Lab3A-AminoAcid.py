# Nicholas McClellan
# CSCI 101 – Section A
# Python Lab 3A
#string for the string representation of amino acid
aminoAcid = ""
#prompt user for inputs
print("Input the chemical elements of the amino acid: ")
carbon = int(input("CARBON>"))
hydrogen = int(input("HYDROGEN>"))
nitrogen = int(input("NITROGEN>"))
oxygen = int(input("OXYGEN>"))
sulfur = int(input("SULFUR>"))

#determining which amino acid to use
if sulfur > 0:
    aminoAcid = "Cysteine"
elif hydrogen == 14:
    aminoAcid = "Arginine"
elif hydrogen == 10:
    aminoAcid = "Glutamine"
elif hydrogen == 9:
    aminoAcid = "Histidine"
elif hydrogen == 8:
    aminoAcid = "Asparagine"
else:
    aminoAcid = "Alanine"

#printing the results
print("OUTPUT " + "C_" + str(carbon) + "H_" + str(hydrogen) + "N_" + str(nitrogen) + "O_" + str(oxygen) + "S_" + str(sulfur))
print("OUTPUT " + aminoAcid)
