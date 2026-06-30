import { slugify } from "../../../shared/utils";
import type { AgentEnv, NormalizedRental, NormalizedResort } from "../types";
import type { OsmElement } from "../types";
import { osmElementCoords, osmElementName } from "./osm";

const RENTAL_MODEL = "@cf/meta/llama-3.1-8b-instruct";

interface AiResortShape {
  summary: string;
  elevation_ft: number | null;
  trail_count: number | null;
}

interface AiRentalShape {
  summary: string;
}

async function runAiJson<T>(
  ai: Ai,
  model: string,
  system: string,
  user: string,
): Promise<T | null> {
  try {
    const response = await ai.run(
      model,
      {
      messages: [
        { role: "system", content: system },
        { role: "user", content: user },
      ],
      max_tokens: 512,
      },
    );

    const text =
      typeof response === "object" && response !== null && "response" in response
        ? String((response as { response: string }).response)
        : JSON.stringify(response);

    const jsonMatch = text.match(/\{[\s\S]*\}/);
    if (!jsonMatch) return null;
    return JSON.parse(jsonMatch[0]) as T;
  } catch {
    return null;
  }
}

export async function normalizeResortWithAi(
  env: AgentEnv,
  el: OsmElement,
  regionName: string,
): Promise<NormalizedResort | null> {
  const name = osmElementName(el);
  const coords = osmElementCoords(el);
  if (!name || !coords) return null;

  const tags = el.tags ?? {};
  const aiResult = await runAiJson<AiResortShape>(
    env.AI,
    "@cf/meta/llama-3.1-8b-instruct",
    `You normalize ski resort data. Respond with ONLY valid JSON: {"summary":"1-2 sentence description","elevation_ft":number|null,"trail_count":number|null}`,
    `Region: ${regionName}\nName: ${name}\nOSM tags: ${JSON.stringify(tags)}`,
  );

  const elevationFromTags = tags.ele ? Math.round(Number(tags.ele) * 3.28084) : null;

  return {
    name,
    slug: slugify(name),
    lat: coords.lat,
    lng: coords.lng,
    elevation_ft: aiResult?.elevation_ft ?? elevationFromTags,
    trail_count: aiResult?.trail_count ?? null,
    website: tags.website ?? tags["contact:website"] ?? null,
    summary:
      aiResult?.summary ??
      `${name} is a ski destination in ${regionName}.`,
  };
}

export async function normalizeRentalWithAi(
  env: AgentEnv,
  el: OsmElement,
  regionName: string,
): Promise<NormalizedRental | null> {
  const name = osmElementName(el);
  const coords = osmElementCoords(el);
  if (!name || !coords) return null;

  const tags = el.tags ?? {};
  const aiResult = await runAiJson<AiRentalShape>(
    env.AI,
    RENTAL_MODEL,
    `You normalize ski rental shop data. Respond with ONLY valid JSON: {"summary":"1 sentence description"}`,
    `Region: ${regionName}\nName: ${name}\nOSM tags: ${JSON.stringify(tags)}`,
  );

  const address = [
    tags["addr:housenumber"],
    tags["addr:street"],
    tags["addr:city"],
    tags["addr:state"],
  ]
    .filter(Boolean)
    .join(" ");

  return {
    name,
    slug: slugify(name),
    lat: coords.lat,
    lng: coords.lng,
    address: address || null,
    phone: tags.phone ?? tags["contact:phone"] ?? null,
    website: tags.website ?? tags["contact:website"] ?? null,
    summary:
      aiResult?.summary ??
      `${name} offers ski and snowboard equipment rentals in ${regionName}.`,
  };
}
