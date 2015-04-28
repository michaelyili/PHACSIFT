#include<stdio.h>
#include<stdlib.h>

void usage()
{
	fprintf(stdout, "-s - the network size is sXs.\n");
	fprintf(stdout, "-r - the value of resistor0\n");
}

int main(int argc, char* argv[])
{
	char a;
	int i = argc;
	int size = 0;
	double r0 = 0;
	if (argc <= 1) {
		fprintf(stdout, "please assign the size of the network...\n");
		usage();
		exit(0);
	} else {
		for (int ind = 1; ind < argc; ind++) {
			if (argv[ind][0] == '-') {
				switch (argv[ind][1]) {
			case 's': size = atoi(argv[++ind]);
				break;
			case 'r': r0 = atof(argv[++ind]);
				break;
			default: fprintf(stdout, "Unknown switch\n");
				break;
				}
			}
		}
	}
	
	FILE* fp = fopen("resnet.sp", "w");
	if (fp == NULL) {
		fprintf(stdout, "failed to openf sp file...\n");
		exit(0);
	}
	
	fprintf(fp, ".title resisitor net\n\n");
	fprintf(fp, "** resistor nerlist\n\n");
	
	fprintf(fp, "** parameters\n");
	fprintf(fp, ".param r0 = %f\n", r0);	

	fprintf(fp, "\n** voltage resources\n");
	for (int i = 0; i < size; i++) {
		if (i == size/2)
			fprintf(fp, "v%d %d 0 1v\n", i+1, i+1);
		else
			fprintf(fp, "v%d %d 0 0v\n", i+1, i+1);
	}
	
	fprintf(fp, "\n** resistor r0\n");
	for (int i = 0; i < size; i++) {
		fprintf(fp, "r%d %d %d r0\n", i+1, (i+1) + size, i+1);
	}
	
	fprintf(fp, "\n** resitor r1\n");
	for (int i=0; i<size-1; i++) {
		fprintf(fp, "r%d %d %d 250\n",
		(i+1) + size, (i+1) + size, (i+1) + size + 1);
	}

	fprintf(fp, "\n** resistor r2\n");
	for (int i=0; i < size-2; i++) {
		fprintf(fp, "r%d %d %d -1k\n",
		(i+1) + size + (size-1), (i+1) + size, (i+1) + size + 2);
	}

	fprintf(fp, "\n.op\n");
	fprintf(fp, ".dc v%d 1v 2v 1v\n", (size+1)/2);
	fprintf(fp, ".print");
	/*for (int i=0; i < size; i++) {
		fprintf(fp, " v(%d)", (i+1) + size);
	}*/
	for (int i=0; i < size; i++) {
		fprintf(fp, " v(%d)", i+1);
	}
	
	fprintf(fp, "\n.print");
	for (int i=0; i < size; i++) {
		fprintf(fp, " i(v%d)", (i+1));
	}

	fprintf(fp, "\n");
	
	fprintf(fp, "\n.end\n");	
	fclose(fp);
	return 0;
}
