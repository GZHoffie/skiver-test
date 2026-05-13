import numpy as np
import pandas as pd

def calculate_read_id(skiver_output_df, k=31):
    lambda_est = skiver_output_df["lambda"].item()
    beta_est = skiver_output_df["beta"].item()

    survival_rate_at_k = np.exp(-lambda_est * (k ** beta_est))
    return (survival_rate_at_k ** (1/k)) * 100


if __name__ == "__main__":
    import argparse
    import pandas as pd

    parser = argparse.ArgumentParser(description="Calculate read ID from Skiver output")
    parser.add_argument("-s", type=str, required=True, help="Path to Skiver output CSV file")
    parser.add_argument("-k", type=int, default=31, help="k-mer size used in Skiver (default: 31)")
    args = parser.parse_args()

    skiver_output_df = pd.read_csv(args.s)
    read_id = calculate_read_id(skiver_output_df, k=args.k)
    print(f"{read_id:.4f}")